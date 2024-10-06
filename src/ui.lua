local center = Vector(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

local function newCard(xoffset)
  local card = {
    id = ID.new(),
    type = "button",
    upgrade = Upgrades.MoveSpeedUpgrade,
    text = Upgrades.MoveSpeedUpgrade.glyph,
    hovered = false,
    hidden = true,
    position = Vector(center.x - xoffset, center.y),
    sprite = love.graphics.newQuad(0, TileSize * 3, TileSize * 2, TileSize * 3, SpriteSheet),
    spriteOffset = Vector(-TileSize, -TileSize * 1.5),
    hitbox = {
      size = Vector(TileSize * 2 * PixelScale, TileSize * 3 * PixelScale),
      offset = Vector(-TileSize * PixelScale, -TileSize * 1.5 * PixelScale)
    },
    update = function(card)
      if card.hovered then
        UI.topText.text = card.upgrade.name
        UI.bottomText.text = card.upgrade.description
      end
    end,
    onMouseDown = function(card)
      -- TODO: handle click
      print("clicked " .. card.id)
    end
  }
  return card
end

local UI = {
  cards = {
    newCard(-24 * PixelScale),
    newCard(0),
    newCard(24 * PixelScale)
  },
  topText = {
    id = ID.new(),
    type = "label",
    text = "choose an uwupgrade",
    hidden = true,
    position = Vector(center.x, center.y - 24 * PixelScale),
  },
  bottomText = {
    id = ID.new(),
    type = "label",
    text = "it will make you gayer",
    hidden = true,
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

function UI.setHidden(hidden)
  UI.cards[1].hidden = hidden
  UI.cards[2].hidden = hidden
  UI.cards[3].hidden = hidden
  UI.topText.hidden = hidden
  UI.bottomText.hidden = hidden
end

return UI
