local center = Vector(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

local function newCard(xoffset)
  local card = {
    id = ID.new(),
    type = "button",
    upgrade = nil,
    text = "",
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
      ApplyUpgradeToEntities(card.upgrade)
      Resource = Resource - UpgradeCosts[card.upgrade.tier]
      UI.setShopHidden(true)
      UI.shopButtons[1].hidden = false
    end
  }
  return card
end

local UI = {
  shopButtons = {
    {
      id = ID.new(),
      type = "button",
      text = "upgrade",
      hidden = false,
      position = Vector(100, love.graphics.getHeight() - 32),
      hitbox = {
        size = Vector(180, 48),
        offset = Vector(-90, -20)
      },
      onMouseDown = function(button)
        if Resource >= UpgradeCosts[1] then
          local choices = GetUpgradeChoices()
          for i = 1, 3 do
            UI.cards[i].upgrade = choices[i]
            UI.cards[i].text = choices[i].glyph
          end

          UI.setShopHidden(false)
          button.hidden = true
        else
          print("can't afford upgrade")
        end
      end
    }
  },
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
  table.insert(Entities, UI.shopButtons[1])
  table.insert(Entities, UI.cards[1])
  table.insert(Entities, UI.cards[2])
  table.insert(Entities, UI.cards[3])
  table.insert(Entities, UI.topText)
  table.insert(Entities, UI.bottomText)
end

function UI.setShopHidden(hidden)
  UI.cards[1].hidden = hidden
  UI.cards[2].hidden = hidden
  UI.cards[3].hidden = hidden
  UI.topText.hidden = hidden
  UI.bottomText.hidden = hidden
end

return UI
