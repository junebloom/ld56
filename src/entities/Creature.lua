local states = {
  idle = {
    name = "idle",
    enter = function(creature)
      creature.input = Vector(0, 0)
      creature.behavior.nextTime = (11 - math.sqrt(creature.stats.smart)) * 0.5
      creature:setAnimation(creature.animations.idle)
    end,
    exit = function(creature)
      local n = math.random()
      if n <= (creature.behavior.mood + creature.stats.smart * 0.01) then
        SetBehaviorState(creature, creature.behavior.states.moveToNode)
      else
        SetBehaviorState(creature, creature.behavior.states.wander)
      end
    end
  },
  wander = {
    name = "wander",
    enter = function(creature)
      creature.input.x = (math.random() - 0.5) * 2
      creature.input.y = (math.random() - 0.5) * 2
      creature.behavior.nextTime = math.random() + 0.2
      creature:setAnimation(creature.animations.walk)
    end,
    exit = function(creature)
      SetBehaviorState(creature, creature.behavior.states.idle)
    end
  },
  moveToNode = {
    name = "moveToNode",
    enter = function(creature)
      creature.behavior.nextTime = 99999

      -- Select node type to move to
      local targetType = nil
      local n = math.random()
      if n < 0.5 then
        targetType = "resourceNode"
      elseif n < 0.75 then
        targetType = "statNode"
      else
        targetType = "enemyNode"
      end

      -- Find closest valid node of selected type
      local closest = nil
      for _, e in pairs(Entities) do
        if (e.type == targetType and (e.harvestable or e.type ~= "resourceNode")) then
          local distance = e.position - creature.position
          if not closest or distance.length < (closest.position - creature.position).length then
            closest = e
          end
        end
      end

      if closest then
        creature.behavior.target = closest
        creature.input = closest.position - creature.position
        creature:setAnimation(creature.animations.walk)
      else
        creature.behavior.currentState.exit(creature)
      end
    end,
    exit = function(creature)
      creature.input = Vector(0, 0)
      local target = creature.behavior.target
      if not target then
        SetBehaviorState(creature, creature.behavior.states.idle)
      elseif target.type == "resourceNode" then
        SetBehaviorState(creature, creature.behavior.states.harvest)
      elseif target.type == "statNode" then
        SetBehaviorState(creature, creature.behavior.states.harvest)
      elseif target.type == "enemyNode" then
        SetBehaviorState(creature, creature.behavior.states.attack)
      else
        error("unrecognized target type")
      end
    end,
    update = function(creature)
      local target = creature.behavior.target
      if not target or (creature.position - target.position).length < 8 * PixelScale then
        creature.behavior.currentState.exit(creature)
      end
    end
  },
  harvest = {
    name = "harvest",
    enter = function(creature)
      creature:setAnimation(creature.animations.idle)
    end,
    exit = function(creature)
      creature.behavior.target = nil
      SetBehaviorState(creature, creature.behavior.states.idle)
    end,
    update = function(creature, dt)
      local target = creature.behavior.target
      target.timeToHarvest = target.timeToHarvest - dt * creature.stats.efficiency
      if target.greedMultiplier ~= creature.stats.greed then
        target.greedMultiplier = creature.stats.greed
      end
      if not target.harvestable then
        creature.behavior.currentState.exit(creature)
      end
    end
  },
  hurt = {
    name = "hurt",
    enter = function(creature)
      print("ouch")
      creature.input = Vector(0, 0)
      creature:setAnimation(creature.animations.idle)

      local x = creature.ouch
      local y = creature.stats.defense

      creature.behavior.nextTime = (x ^ 2 + x) * (1 / (y ^ 2) + 1)

      if y >= x * 2 then creature.behavior.nextTime = 0 end
    end,
    exit = function(creature)
      SetBehaviorState(creature, creature.behavior.lastState)
    end
  }
}

local function create(x, y)
  local creature = {
    id = ID.new(),
    type = "creature",
    behavior = {
      target = nil,
      nextTime = 0,
      currentState = nil,
      lastState = nil,
      mood = 0.2, --Chance to harvest
      states = states
    },
    stats = {
      greed = 1,
      power = 1,
      scary = 1,
      defense = 1,
      moveSpeed = 1,
      smart = 1, -- cap 121
      efficiency = 1
    },
    ouch = 0, -- damage received on hurt
    input = Vector(0, 0),
    position = Vector(x, y),
    sprite = love.graphics.newQuad(0, 0, TileSize, TileSize, SpriteSheet),
    spriteOffset = Vector(-TileSize / 2, -TileSize),
    facing = 1,
    frameTime = 0,
    currentFrame = 1,
    animation = nil,
    animations = {
      idle = {
        fps = 6,
        frames = {
          love.graphics.newQuad(TileSize * 0, 0, TileSize, TileSize, SpriteSheet),
        }
      },
      walk = {
        fps = 6,
        frames = {
          love.graphics.newQuad(TileSize * 1, 0, TileSize, TileSize, SpriteSheet),
          love.graphics.newQuad(TileSize * 0, 0, TileSize, TileSize, SpriteSheet),
        }
      }
    },
    setAnimation = function(self, animation)
      if self.animation == animation then return end
      self.animation = animation
      self.frameTime = 0
      self.currentFrame = 1
    end
  }

  SetBehaviorState(creature, creature.behavior.states.idle)
  creature.behavior.nextTime = 0.1

  for _, upgrade in pairs(PurchasedUpgrades) do
    if upgrade.types.creature then upgrade.apply(creature) end
  end

  return creature
end

return { create = create }
