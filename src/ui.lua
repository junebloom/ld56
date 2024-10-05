local function initUI()
  table.insert(Entities, {
    type = "button",
    upgrade = Upgrades.MoveSpeedUpgrade,
    text = Upgrades.MoveSpeedUpgrade.glyph,
    position = Vector(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2),
    sprite = love.graphics.newQuad(0, TileSize * 3, TileSize * 2, TileSize * 3, SpriteSheet),
    spriteOffset = Vector(-TileSize, -TileSize * 1.5),
    hitbox = {
      size = Vector(TileSize * 2 * PixelScale, TileSize * 3 * PixelScale),
      offset = Vector(-TileSize, -TileSize * 1.5)
    }
  })
end

return initUI
