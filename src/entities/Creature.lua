local states = {
  idle = {
    name = "idle",
    enter = function(creature)
      creature.behavior.nextTime = 6 - math.sqrt(creature.stats.smart)
    end,
    exit = function (creature)
      local n = math.random()
      if n <= 0.8 then
        setBehaviorState(creature, creature.behavior.states.wander)
      else
        setBehaviorState(creature, creature.behavior.states.moveToResource)
      end
    end
  },
  wander = {
    name = "wander",
    enter = function(creature)
      creature.input.x = (math.random() - 0.5) * 2
      creature.input.y = (math.random() - 0.5) * 2
      creature.behavior.nextTime = math.random() + 0.2
    end,
    exit = function(creature)
      creature.input = Vector(0, 0)
      setBehaviorState(creature, creature.behavior.states.idle)
    end
  },
  moveToResource = {
    name = "moveToResource",
    enter = function (creature)
      creature.behavior.nextTime = 99999
      local closest = nil

      for _,e in pairs(Entities) do
        if (e.harvestable) then
          local distanceToEntity = e.position - creature.position
          if not closest or distanceToEntity.length < (closest.position - creature.position).length then
            closest = e
          end
        end
      end

      if closest then
        creature.behavior.target = closest
        creature.input = closest.position - creature.position
      else
        creature.behavior.currentState.exit(creature)
      end
    end,
    exit = function (creature)
      creature.input = Vector(0, 0)
      if creature.behavior.target then
        setBehaviorState(creature, creature.behavior.states.harvestResource)
      else
        setBehaviorState(creature, creature.behavior.states.idle)
      end
    end,
    update = function (creature)
      local target = creature.behavior.target
      if not target or (creature.position - target.position).length < 8 * PixelScale then
        creature.behavior.currentState.exit(creature)
      end
    end
  },
  harvestResource = {
    name = "harvestResource",
    enter = function(creature)
      -- 
    end,
    exit = function(creature)
      creature.behavior.target = nil
      setBehaviorState(creature, creature.behavior.states.idle)
    end,
    update = function (creature, dt)
      local target = creature.behavior.target
      target.timeToHarvest = target.timeToHarvest - dt * creature.stats.efficiency
      if not target.harvestable then
        creature.behavior.currentState.exit(creature)
      end
    end
  }
}

local function create(x, y)
  local creature = {
    id = ID.new(),
    behavior = {
      target = nil,
      nextTime = 0,
      currentState = nil,
      states = states
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
    input = Vector(0, 0),
    position = Vector(x, y),
    sprite = love.graphics.newQuad(0,0,TileSize,TileSize, SpriteSheet),
    spriteOffset = Vector(0,0),
    facing = 1,
    frameTime = 0,
    currentFrame = 1,
    animation = nil,
    animations = {
      idle = {
        fps = 6,
        frames = {
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

  setBehaviorState(creature, creature.behavior.states.idle)

  return creature
end

return { create = create }