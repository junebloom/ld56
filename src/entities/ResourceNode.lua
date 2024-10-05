local function create(x, y)
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

return { create = create }