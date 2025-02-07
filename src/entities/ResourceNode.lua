local states = {
  growing = {
    name = "growing",
    enter = function(node)
      node:setAnimation(node.animations.growing)
      node.behavior.nextTime = node.growthTime * (1 / 0.5 + node.stats.production * 0.5)
    end,
    exit = function(node)
      SetBehaviorState(node, node.behavior.states.ready)
    end
  },
  ready = {
    name = "ready",
    enter = function(node)
      node:setAnimation(node.animations.ready)
      node.timeToHarvest = node.baseTimeToHarvest
      node.harvestable = true
      node.behavior.nextTime = 99999
    end,
    exit = function(node)
      node.harvestable = false
      Resource = Resource + (node.stats.nodeTier ^ 2) * node.stats.production * node.greedMultiplier
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
    type = "resourceNode",
    supertype = "node",
    position = Vector(x, y),
    spriteOffset = Vector(-TileSize / 2, -TileSize * 1.5),
    stats = {
      production = 1,
      nodeTier = 1
    },
    growthTime = 6,
    harvestable = true,
    baseTimeToHarvest = 5,
    timeToHarvest = 5,
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
        UI.topText.text = "loosh vent\nlv" .. self.stats.nodeTier .. "\n" .. self.behavior.currentState.name
        UI.bottomText.text = "produces loosh for upgrades."
      end
    end,
    frameTime = 0,
    currentFrame = 1,
    animation = nil,
    animations = {
      growing = {
        fps = 3,
        frames = {
          love.graphics.newQuad(TileSize * 0, TileSize, TileSize, TileSize * 2, SpriteSheet)
        }
      },
      ready = {
        fps = 3,
        frames = {
          love.graphics.newQuad(TileSize * 1, TileSize, TileSize, TileSize * 2, SpriteSheet),
          love.graphics.newQuad(TileSize * 2, TileSize, TileSize, TileSize * 2, SpriteSheet)
        }
      },
    },
    setAnimation = function(self, animation)
      if self.animation == animation then return end
      self.animation = animation
      self.frameTime = 0
      self.currentFrame = 1
    end
    -- hitbox = {
    --   size = Vector(8 * PixelScale, 8 * PixelScale),
    --   offset = Vector(0, 0)
    -- }
  }

  SetBehaviorState(node, node.behavior.states.ready)

  for _, upgrade in pairs(PurchasedUpgrades) do
    if upgrade.types.resourceNode then upgrade.apply(node) end
  end

  return node
end

return { create = create }
