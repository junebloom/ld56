local center = Vector(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

local cardSprite = {
  default = love.graphics.newQuad(3 * TileSize, 1 * TileSize, TileSize * 2, TileSize * 3, SpriteSheet),
  hover = love.graphics.newQuad(5 * TileSize, 1 * TileSize, TileSize * 2, TileSize * 3, SpriteSheet),
}

local function newCard(xoffset)
  local card = {
    id = ID.new(),
    type = "button",
    upgrade = nil,
    text = "",
    hovered = false,
    hidden = true,
    position = Vector(center.x - xoffset, center.y),
    sprite = cardSprite.default,
    spriteOffset = Vector(-TileSize, -TileSize * 1.5),
    hitbox = {
      size = Vector(TileSize * 2 * PixelScale, TileSize * 3 * PixelScale),
      offset = Vector(-TileSize * PixelScale, -TileSize * 1.5 * PixelScale)
    },
    update = function(card)
      if card.hovered and not card.hidden then
        UI.topText.text = card.upgrade.name
        UI.bottomText.text = card.upgrade.description
      end

      if card.hovered then
        card.sprite = cardSprite.hover
        card.flashing = 1
      else
        card.sprite = cardSprite.default
        card.flashing = 0
      end
    end,
    onMouseDown = function(card)
      table.insert(PurchasedUpgrades, card.upgrade)
      Resource = Resource - UpgradeCosts[card.upgrade.tier]
      ApplyUpgradeToEntities(card.upgrade)
      UI.setShopHidden(true)
      UI.setButtonsHidden(false)
    end
  }
  return card
end

local shopButtonOffset = 0

local UI = {
  shopButtons = {
    {
      id = ID.new(),
      type = "button",
      text = "upgrade",
      hidden = false,
      clicked = false,
      flashing = true,
      position = Vector((16 + shopButtonOffset) * PixelScale, love.graphics.getHeight() - 5 * PixelScale),
      hitbox = {
        size = Vector(180, 48),
        offset = Vector(-90, -20)
      },
      update = function(shopButton)
        if not shopButton.hidden and shopButton.hovered and Resource < UpgradeCosts[1] then
          UI.bottomText.text = "need " .. UpgradeCosts[1] * 10 .. " loosh"
          UI.bottomText.hidden = false
        elseif not shopButton.hidden then
          UI.bottomText.hidden = true
        end

        if shopButton.hovered or not shopButton.clicked then
          shopButton.flashing = 1
        else
          shopButton.flashing = 0
        end
      end,
      onMouseDown = function(shopButton)
        if Resource >= UpgradeCosts[1] then
          local choices = GetUpgradeChoices(1)
          for i = 1, 3 do
            UI.cards[i].upgrade = choices[i]
            UI.cards[i].text = choices[i].glyph
          end

          UI.setShopHidden(false)
          UI.setButtonsHidden(true)
          shopButton.clicked = true
        else
          print("can't afford upgrade")
        end
      end
    },
    {
      id = ID.new(),
      type = "button",
      text = "t2",
      hidden = true,
      clicked = false,
      flashing = true,
      position = Vector((38 + shopButtonOffset) * PixelScale, love.graphics.getHeight() - 5 * PixelScale),
      hitbox = {
        size = Vector(48, 48),
        offset = Vector(-24, -20)
      },
      update = function(shopButton)
        if not shopButton.hidden and shopButton.hovered and Resource < UpgradeCosts[2] then
          UI.bottomText.text = "need " .. UpgradeCosts[2] * 10 .. " loosh"
          UI.bottomText.hidden = false
        elseif not shopButton.hidden then
          UI.bottomText.hidden = true
        end

        if shopButton.hovered or not shopButton.clicked then
          shopButton.flashing = 1
        else
          shopButton.flashing = 0
        end
      end,
      onMouseDown = function(shopButton)
        if Resource >= UpgradeCosts[2] then
          local choices = GetUpgradeChoices(2)
          for i = 1, 3 do
            UI.cards[i].upgrade = choices[i]
            UI.cards[i].text = choices[i].glyph
          end

          UI.setShopHidden(false)
          UI.setButtonsHidden(true)
          shopButton.clicked = true
        else
          print("can't afford upgrade")
        end
      end
    },
    {
      id = ID.new(),
      type = "button",
      text = "t3",
      hidden = true,
      clicked = false,
      flashing = true,
      position = Vector((50 + shopButtonOffset) * PixelScale, love.graphics.getHeight() - 5 * PixelScale),
      hitbox = {
        size = Vector(48, 48),
        offset = Vector(-24, -20)
      },
      update = function(shopButton)
        if not shopButton.hidden and shopButton.hovered and Resource < UpgradeCosts[3] then
          UI.bottomText.text = "need " .. UpgradeCosts[3] * 10 .. " loosh"
          UI.bottomText.hidden = false
        elseif not shopButton.hidden then
          UI.bottomText.hidden = true
        end

        if shopButton.hovered or not shopButton.clicked then
          shopButton.flashing = 1
        else
          shopButton.flashing = 0
        end
      end,
      onMouseDown = function(shopButton)
        if Resource >= UpgradeCosts[3] then
          local choices = GetUpgradeChoices(3)
          for i = 1, 3 do
            UI.cards[i].upgrade = choices[i]
            UI.cards[i].text = choices[i].glyph
          end

          UI.setShopHidden(false)
          UI.setButtonsHidden(true)
          shopButton.clicked = true
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
  },
  looshParticles = {
    id = ID.new(),
    type = "label",
    hidden = false,
    position = Vector(128 * PixelScale, 96 * PixelScale),
    spriteOffset = Vector(-16, -16),
    frameTime = 0,
    currentFrame = 1,
    animation = {
      fps = 3,
      frames = {
        love.graphics.newQuad(TileSize * 1, TileSize, TileSize, TileSize, SpriteSheet),
        love.graphics.newQuad(TileSize * 2, TileSize, TileSize, TileSize, SpriteSheet)
      }
    }
  }
}

function UI.init()
  table.insert(Entities, UI.shopButtons[1])
  table.insert(Entities, UI.shopButtons[2])
  table.insert(Entities, UI.shopButtons[3])
  table.insert(Entities, UI.cards[1])
  table.insert(Entities, UI.cards[2])
  table.insert(Entities, UI.cards[3])
  table.insert(Entities, UI.topText)
  table.insert(Entities, UI.bottomText)
  table.insert(Entities, UI.looshParticles)
end

function UI.setShopHidden(hidden)
  UI.cards[1].hidden = hidden
  UI.cards[2].hidden = hidden
  UI.cards[3].hidden = hidden
  UI.topText.hidden = hidden
  UI.bottomText.hidden = hidden
end

function UI.setButtonsHidden(hidden)
  UI.shopButtons[1].hidden = hidden
  if (CreatureTier >= 2) then
    UI.shopButtons[2].hidden = hidden
  end
  if (CreatureTier >= 3) then
    UI.shopButtons[3].hidden = hidden
  end
end

return UI
