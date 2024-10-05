local function create(x, y)
  local creature = {
    behavior = {
      nextTime = 0,
      currentState = {},
      states = {
        idle = {
          enter = function(creature)
            print("creature idling")
            creature.behavior.nextTime = 6 - math.sqrt(creature.stats.smart)
          end,
          exit = function (creature)
            setEntityState(creature, creature.behavior.states.wander)
          end
        },
        wander = {
          enter = function(creature)
            print("creature wandering")
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
            print("creature moving to harvest")
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
            print("creature harvesting")
          end,
          exit = function(creature)
            creature.behavior.states.moveToResource.target = nil
            setEntityState(creature, creature.behavior.states.idle)
          end,
          update = function (creature, dt)
            local target = creature.behavior.states.moveToResource.target
            target.timeToHarvest = target.timeToHarvest - dt * creature.stats.efficiency
            if not target.harvestable then
              creature.behavior.currentState.exit(creature)
            end
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

return { create = create }