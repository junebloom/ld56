local states = {
  growing = {
    name = "growing",
    enter = function(node)
      node.sprite = love.graphics.newQuad(0, TileSize, TileSize, TileSize * 2, SpriteSheet)
      node.behavior.nextTime = 11 - math.sqrt(node.stats.production)
    end,
    exit = function(node)
      SetBehaviorState(node, node.behavior.states.ready)
    end
  },
  ready = {
    name = "ready",
    enter = function(node)
      node.sprite = love.graphics.newQuad(TileSize, TileSize, TileSize, TileSize * 2, SpriteSheet)
      node.timeToHarvest = node.baseTimeToHarvest
      node.harvestable = true
      node.behavior.nextTime = 99999
    end,
    exit = function(node)
      node.harvestable = false
      Resource = Resource + (node.stats.nodeTier^2) * node.stats.production * node.greedMultiplier
      node.greedMultiplier = 1
      SetBehaviorState(node, node.behavior.states.growing)
    end,
    update = function(node)
      if node.timeToHarvest <= 0 then node.behavior.currentState.exit(node) end
    end
  }
}

local function create(x, y)
  local node = {
    id = ID.new(),
    type = "node",
    position = Vector(x, y),
    spriteOffset = Vector(0, -TileSize),
    hitbox = {
      size = Vector(8 * PixelScale, 8 * PixelScale),
      offset = Vector(0, 0)
    },
    stats = {
      production = 1,
      nodeTier = 1
    },
    harvestable = true,
    baseTimeToHarvest = 10, 
    timeToHarvest = 10,
    greedMultiplier = 1,
    behavior = {
      nextTime = 0,
      currentState = nil,
      states = states
    }
  }

  SetBehaviorState(node, node.behavior.states.ready)

  for _, upgrade in pairs(PurchasedUpgrades) do
    if upgrade.type.node then upgrade.apply(node) end
  end

  return node
end

return { create = create }
