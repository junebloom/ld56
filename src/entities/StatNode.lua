local states = {
  growing = {
    name = "growing",
    enter = function(node)
      node:setAnimation(node.animations.growing[node.stat])
      node.behavior.nextTime = node.growthTime * (1 / 0.5 + node.stats.production * 0.5)
    end,
    exit = function(node)
      SetBehaviorState(node, node.behavior.states.ready)
    end
  },
  ready = {
    name = "ready",
    enter = function(node)
      node:setAnimation(node.animations.ready[node.stat])
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
    spriteOffset = Vector(0, 0),
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
    hitbox = {
      size = Vector(48, 48),
      offset = Vector(-24, -24)
    },
    update = function(self, dt)
      if self.hovered and not UI.isShopOpen then
        if self.stat == "smart" then
          UI.topText.text = "fungal brain\nlv" .. self.stats.nodeTier .. "\n" .. self.behavior.currentState.name
          UI.bottomText.text = "eating this sharpens the mind."
        elseif self.stat == "scary" then
          UI.topText.text = "withered fruit\nlv" .. self.stats.nodeTier .. "\n" .. self.behavior.currentState.name
          UI.bottomText.text = "eating this makes creatures scarier."
        elseif self.stat == "power" then
          UI.topText.text = "cosmic vessel\nlv" .. self.stats.nodeTier .. "\n" .. self.behavior.currentState.name
          UI.bottomText.text = "drinking from this gives strength."
        end
      end
    end,
    frameTime = 0,
    currentFrame = 1,
    animation = nil,
    animations = {
      growing = {
        smart = {
          fps = 3,
          offset = Vector(-TileSize, -TileSize * 1.5),
          frames = {
            love.graphics.newQuad(TileSize * 0, TileSize * 6, TileSize * 2, TileSize * 2, SpriteSheet),
          }
        },
        scary = {
          fps = 3,
          offset = Vector(-TileSize, -TileSize * 1.5),
          frames = {
            love.graphics.newQuad(TileSize * 0, TileSize * 4, TileSize * 2, TileSize * 2, SpriteSheet),
          }
        },
        power = {
          fps = 3,
          offset = Vector(-TileSize / 2, -TileSize / 2),
          frames = {
            love.graphics.newQuad(TileSize * 0, TileSize * 3, TileSize * 1, TileSize * 1, SpriteSheet),
          }
        }
      },
      ready = {
        smart = {
          fps = 3,
          offset = Vector(-TileSize, -TileSize * 1.5),
          frames = {
            love.graphics.newQuad(TileSize * 2, TileSize * 6, TileSize * 2, TileSize * 2, SpriteSheet),
            love.graphics.newQuad(TileSize * 4, TileSize * 6, TileSize * 2, TileSize * 2, SpriteSheet),
          }
        },
        scary = {
          fps = 3,
          offset = Vector(-TileSize, -TileSize * 1.5),
          frames = {
            love.graphics.newQuad(TileSize * 2, TileSize * 4, TileSize * 2, TileSize * 2, SpriteSheet),
            love.graphics.newQuad(TileSize * 4, TileSize * 4, TileSize * 2, TileSize * 2, SpriteSheet),

          }
        },
        power = {
          fps = 3,
          offset = Vector(-TileSize / 2, -TileSize / 2),
          frames = {
            love.graphics.newQuad(TileSize * 1, TileSize * 3, TileSize * 1, TileSize * 1, SpriteSheet),
            love.graphics.newQuad(TileSize * 2, TileSize * 3, TileSize * 1, TileSize * 1, SpriteSheet),
          }
        }
      },
    },
    setAnimation = function(self, animation)
      if self.animation == animation then return end
      self.animation = animation
      self.frameTime = 0
      self.currentFrame = 1
    end
  }

  SetBehaviorState(node, node.behavior.states.ready)

  for _, upgrade in pairs(PurchasedUpgrades) do
    if upgrade.types.statNode then upgrade.apply(node) end
  end

  return node
end

return { create = create }
