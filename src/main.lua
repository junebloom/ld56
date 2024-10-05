dbg = require("utilities.debugger")
Vector = require("utilities.brinevector")
ID = require("utilities.id")

Upgrades = require("upgrades")
ResourceNode = require("entities.ResourceNode")
Creature = require("entities.Creature")

local processBehaviorStates = require("systems.processBehaviorStates")
local moveEntities = require("systems.moveEntities")
local drawSprites = require("systems.drawSprites")
local drawText = require("systems.drawText")
local drawHitBoxes = require("systems.drawHitboxes")

love.graphics.setBackgroundColor(5 / 255, 31 / 255, 57 / 255)

SpriteSheet = love.graphics.newImage("assets/spritesheet.png")
SpriteSheet:setFilter("nearest", "nearest")

Font = love.graphics.newImageFont("assets/font.png", "abcdefghijklmnopqrstuvwxyz0123456789+-%*/.: ")
Font:setFilter("nearest", "nearest")
love.graphics.setFont(Font)

TileSize = 8
PixelScale = 6

Entities = {}
TimeScale = 1
DEBUG = true

Resource = 0
PurchasedUpgrades = {}

function ApplyUpgradeToEntities(upgrade)
  for _, e in pairs(Entities) do
    if upgrade.types[e.type] then upgrade.apply(e) end
  end
end

function GetUpgradeChoices()
  local availableUpgrades = {}
  for _, upgrade in pairs(Upgrades) do
    if upgrade.available then table.insert(availableUpgrades, upgrade) end
  end

  local choices = {}
  for i = 1, 3 do
    local n = math.random(#availableUpgrades)
    if DEBUG then print(availableUpgrades[n].name) end
    table.insert(choices, availableUpgrades[n])
    table.remove(availableUpgrades, n)
  end

  return choices
end

function setBehaviorState(entity, state)
  if DEBUG then print("entity " .. entity.id .. ": " .. state.name) end
  entity.behavior.currentState = state
  state.enter(entity)
end

function love.load()
  table.insert(Entities, ResourceNode.create(128, 128))
  table.insert(Entities, ResourceNode.create(256, 128))
  table.insert(Entities, Creature.create(256, 256))
  table.insert(Entities, Creature.create(200, 256))

  -- UI
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

function love.keypressed(key)
  if key == "escape" then
    if TimeScale == 0 then
      TimeScale = 1
    else
      TimeScale = 0
    end
  end
end

function love.update(dt)
  local scaledDeltaTime = dt * TimeScale
  processBehaviorStates(Entities, scaledDeltaTime)
  moveEntities(Entities, scaledDeltaTime)
  -- setAnimationsFromInput(entities, scaledDeltaTime)
  -- processAnimations(entities, scaledDeltaTime)
end

function love.draw()
  drawSprites(Entities)
  drawText(Entities)
  if DEBUG then drawHitBoxes(Entities) end
end
