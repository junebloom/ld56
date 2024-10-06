local center = Vector(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

local function initUI()
  -- Upgrade cards
  table.insert(Entities, {
    type = "button",
    upgrade = nil,
    text = "",
    position = Vector(center.x - 24 * PixelScale, center.y),
    sprite = love.graphics.newQuad(0, TileSize * 3, TileSize * 2, TileSize * 3, SpriteSheet),
    spriteOffset = Vector(-TileSize, -TileSize * 1.5),
    hitbox = {
      size = Vector(TileSize * 2 * PixelScale, TileSize * 3 * PixelScale),
      offset = Vector(-TileSize * PixelScale, -TileSize * 1.5 * PixelScale)
    }
  })
  table.insert(Entities, {
    type = "button",
    upgrade = Upgrades.MoveSpeedUpgrade,
    text = Upgrades.MoveSpeedUpgrade.glyph,
    position = Vector(center.x, center.y),
    sprite = love.graphics.newQuad(0, TileSize * 3, TileSize * 2, TileSize * 3, SpriteSheet),
    spriteOffset = Vector(-TileSize, -TileSize * 1.5),
    hitbox = {
      size = Vector(TileSize * 2 * PixelScale, TileSize * 3 * PixelScale),
      offset = Vector(-TileSize * PixelScale, -TileSize * 1.5 * PixelScale)
    }
  })
  table.insert(Entities, {
    type = "button",
    upgrade = nil,
    text = "",
    position = Vector(center.x + 24 * PixelScale, center.y),
    sprite = love.graphics.newQuad(0, TileSize * 3, TileSize * 2, TileSize * 3, SpriteSheet),
    spriteOffset = Vector(-TileSize, -TileSize * 1.5),
    hitbox = {
      size = Vector(TileSize * 2 * PixelScale, TileSize * 3 * PixelScale),
      offset = Vector(-TileSize * PixelScale, -TileSize * 1.5 * PixelScale)
    }
  })

  -- Top Text
  table.insert(Entities, {
    type = "label",
    text = "something",
    position = Vector(center.x, center.y - 24 * PixelScale),
  })

  -- Bottom Text
  table.insert(Entities, {
    type = "label",
    text = "meow: +50% ... 3 * 2 - 1 / 0",
    position = Vector(center.x, center.y + 24 * PixelScale),
  })
end

return initUI
