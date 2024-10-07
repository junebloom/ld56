local states = {
  growing = {
    name = "growing",
    enter = function(node)
      node.sprite = love.graphics.newQuad(0, TileSize, TileSize, TileSize * 2, SpriteSheet)
      node.behavior.nextTime = node.growthTime * (1 / 0.5 + node.stats.production * 0.5)
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
      local upgrade = {
        types = Upgrades.HarvestGrowthStat[node.stat].types,
        apply = function()
          ApplyUpgradeToEntities(Upgrades.HarvestGrowthStat[node.stat], node)
        end
      }

      ApplyUpgradeToEntities(upgrade)
      table.insert(PurchasedUpgrades, upgrade)

      node.harvestable = false
      SetBehaviorState(node, node.behavior.states.growing)
    end,
    update = function(node)
      if node.timeToHarvest <= 0 then node.behavior.currentState.exit(node) end
    end
  }
}

local function create(x, y, stat)
  local node = {
    id = ID.new(),
    type = "statNode",
    supertype = "node",
    stat = stat,
    position = Vector(x, y),
    spriteOffset = Vector(-TileSize / 2, -TileSize * 1.5),
    stats = {
      production = 1,
      nodeTier = 1
    },
    growthTime = 11,
    harvestable = true,
    baseTimeToHarvest = 3,
    timeToHarvest = 3,
    greedMultiplier = 1,
    behavior = {
      nextTime = 0,
      currentState = nil,
      states = states
    },
    -- hitbox = {
    --   size = Vector(8 * PixelScale, 8 * PixelScale),
    --   offset = Vector(0, 0)
    -- }
  }

  SetBehaviorState(node, node.behavior.states.ready)

  for _, upgrade in pairs(PurchasedUpgrades) do
    if upgrade.type.node then upgrade.apply(node) end
  end

  return node
end

return { create = create }
