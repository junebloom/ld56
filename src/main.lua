local dbg = require("debugger")
local Vector = require("brinevector")

local pixelScale = 6

local resource = 0

local entities = {}

function setEntityState(entity, state)
  state.enter(entity)
  entity.behavior.currentState = state
end

function createCreature(x, y)
  local creature = {
    behavior = {
      nextTime = 0,
      currentState = {},
      states = {
        idle = {
          enter = function(creature)
            creature.behavior.nextTime = 6 - math.sqrt(creature.stats.smart)
          end,
          exit = function (creature)
            setEntityState(creature, creature.behavior.states.wander)
          end
        },
        wander = {
          enter = function(creature)
            creature.input.x = (math.random() - 0.5) * 2
            creature.input.y = (math.random() - 0.5) * 2
            creature.behavior.nextTime = math.random() + 0.2
          end,
          exit = function(creature)
            creature.input = Vector(0, 0)
            setEntityState(creature, creature.behavior.states.idle)
          end
        },
        moveToResource = {
          target = nil,
          enter = function (creature)
            print("moving to harvest")
            creature.behavior.nextTime = 99999
            local closest = nil
            for _,e in pairs(entities) do
              if (e.harvestable) then
                local distanceToEntity = e.position - creature.position
                if not closest or distanceToEntity < closest.position - creature.position then
                  closest = e
                end
              end
            end

            if closest then
              creature.behavior.states.moveToResource.target = closest
              creature.input = closest.position - creature.position
            end
          end,
          exit = function (creature)
            print("done moving to harvest")
            creature.input = Vector(0, 0)
            setEntityState(creature, creature.behavior.states.harvestResource)
          end,
          update = function (creature)
            local target = creature.behavior.states.moveToResource.target
            if (creature.position - target.position).length < 8 * pixelScale then
              creature.behavior.currentState.exit(creature)
            end
          end
        },
        harvestResource = {
          enter = function(creature)
          end,
          exit = function(creature)
            print("done harvesting")
          end,
          update = function (creature)
            -- TODO: use closest reference to update node being harvested
          end
        }
      },
    },
    stats = {
      greed = 1,
      power = 1,
      scary = 1,
      defense = 1,
      speed = 1,
      smart = 1, -- cap 36
      efficiency = 1
    },
    hitbox = {
      size = Vector(8 * pixelScale, 8 *pixelScale),
      offset = Vector(0, 0)
    },
    input = Vector(0, 0),
    position = Vector(x, y),
    sprite = nil,
    facing = 1,
    frameTime = 0,
    currentFrame = 1,
    animation = nil,
    animations = {
      idle = {
        fps = 6,
        frames = {}
      }
    },
    setAnimation = function(self, animation)
      if self.animation == animation then return end
      self.animation = animation
      self.frameTime = 0
      self.currentFrame = 1
    end
  }

  setEntityState(creature, creature.behavior.states.moveToResource)

  return creature
end

function createResourceNode(x, y)
  local node = {
    position = Vector(x, y),
    hitbox = {
      size = Vector(8 * pixelScale, 8 *pixelScale),
      offset = Vector(0, 0)
    },
    stats = {
      production = 1
    },
    harvestable = true,
    timeToHarvest = 1,
    behavior = {
      nextTime = 0,
      currentState = {},
      states = {
        growing = {
          enter = function(node)
            print("growing...")
            node.behavior.nextTime = 6 - math.sqrt(node.stats.production)
          end,
          exit = function (node)
            node.harvestable = true
            setEntityState(node, node.behavior.states.ready)
          end
        },
        ready = {
          enter = function(node)
            print("ready!")
            node.behavior.nextTime = 99999
          end,
          exit = function(node)
            node.harvestable = false
            resource = resource + 1
            setEntityState(node, node.behavior.states.growing)
          end,
          update = function(node)
            if node.timeToHarvest <= 0 then node.behavior.currentState.exit(node) end
          end
        }
      },
    }
  }

  setEntityState(node, node.behavior.states.ready)

  return node
end

-- Utilities

-- Systems

function moveEntities(entities, dt)
  for _,e in pairs(entities) do
    if e.input then
      e.position = e.position + e.input.normalized * e.stats.speed * 10 * dt
    end
  end
end

function detectCollisions(entities)
  for _,a in pairs(entities) do
    for _,b in pairs(entities) do
      if a ~= b and a.hitbox and b.hitbox then
        if isAABBColliding(getBounds(a), getBounds(b)) then
          -- do something
        end
      end
    end
  end
end

function processCreatureActions(entities, dt)
  for _,e in pairs(entities) do
    if e.behavior ~= nil then
      e.behavior.nextTime = e.behavior.nextTime - dt

      if e.behavior.nextTime <= 0 then
        e.behavior.currentState.exit(e)
      end

      if e.behavior.currentState.update then e.behavior.currentState.update(e, dt) end
    end
  end
end

-- Determine sprite facing and animation from input
function setAnimationsFromInput(entities)
  for _,e in pairs(entities) do
    if e.input then
      if e.input.x > 0 then e.facing = 1 end
      if e.input.x < 0 then e.facing = -1 end

      if e.animations then
        if e.input.x == 0 and e.input.y == 0 then
          e:setAnimation(e.animations.idle)
        else
          e:setAnimation(e.animations.walk)
        end
      end
    end
  end
end

-- Update sprite animation frames
function processAnimations(entities, dt)
  for _,e in pairs(entities) do
    if e.animations then
      e.frameTime = e.frameTime + dt

      if (e.frameTime >= 1 / e.animation.fps) then
        e.currentFrame = e.currentFrame + 1
        e.frameTime = 0
      end

      if (e.currentFrame > #e.animation.frames) then
        e.currentFrame = 1
      end

      e.sprite = e.animation.frames[e.currentFrame]
    end
  end
end

function drawSprites()
  love.graphics.setColor(1,1,1)
  for _,e in pairs(entities) do
    if e.sprite then
      love.graphics.draw(e.sprite, e.position.x, e.position.y, 0, 4 * (e.facing or 1), 4, e.sprite:getWidth() / 2, e.sprite:getHeight())
    end
  end
end

function drawHitBoxes()
  love.graphics.setColor(1,0,0)
  for _,e in pairs(entities) do
    if e.hitbox then
      love.graphics.rectangle("line", e.position.x + e.hitbox.offset.x, e.position.y + e.hitbox.offset.y, e.hitbox.size.x, e.hitbox.size.y)
    end
  end
end

-- Love callbacks

function love.load()
  -- for _,animation in pairs(entities.creature.animations) do
  --   for _,frame in pairs(animation.frames) do
  --     frame:setFilter("nearest", "nearest")
  --   end
  -- end
  table.insert(entities, createResourceNode(128, 128))
  table.insert(entities, createCreature(256, 256))
end

function love.update(dt)
  processCreatureActions(entities, dt)
  moveEntities(entities, dt)
  detectCollisions(entities, dt)
  -- setAnimationsFromInput(entities, dt)
  -- processAnimations(entities, dt)
end

function love.draw()
  -- drawSprites()
  drawHitBoxes()
end