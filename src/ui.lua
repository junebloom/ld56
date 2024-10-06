local center = Vector(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

local UI = {
  cards = {
    {
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
    },
    {
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
    },
    {
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
    }
  },
  topText = {
    type = "label",
    text = "something",
    position = Vector(center.x, center.y - 24 * PixelScale),
  },
  bottomText = {
    type = "label",
    text = "meow: +50% ... 3 * 2 - 1 / 0",
    position = Vector(center.x, center.y + 24 * PixelScale),
  }
}

function UI.init()
  table.insert(Entities, UI.cards[1])
  table.insert(Entities, UI.cards[2])
  table.insert(Entities, UI.cards[3])
  table.insert(Entities, UI.topText)
  table.insert(Entities, UI.bottomText)
end

return UI
