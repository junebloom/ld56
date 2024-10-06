-- Import utilities
dbg = require("utilities.debugger")
Vector = require("utilities.brinevector")
ID = require("utilities.id")

-- Import entities
ResourceNode = require("entities.ResourceNode")
Creature = require("entities.Creature")

-- Import systems
local processMouseHover = require("systems.processMouseHover")
local processBehaviorStates = require("systems.processBehaviorStates")
local processEntityUpdate = require("systems.processEntityUpdate")
local processAnimations = require("systems.processAnimations")
local processFacing = require("systems.processFacing")
local moveEntities = require("systems.moveEntities")
local drawSprites = require("systems.drawSprites")
local drawText = require("systems.drawText")
local drawHitBoxes = require("systems.drawHitboxes")

-- Game state
DEBUG = true
TimeScale = 1
Entities = {}

Resource = 3

Upgrades = require("upgrades")
UpgradeCosts = { 1, 3, 9 }
PurchasedUpgrades = {}

-- Configure graphics
local bgImage = love.graphics.newImage("assets/bg.png")
bgImage:setFilter("nearest", "nearest")
love.graphics.setBackgroundColor(5 / 255, 31 / 255, 57 / 255)

local font = love.graphics.newImageFont("assets/font.png", "abcdefghijklmnopqrstuvwxyz0123456789+-%*/.: ")
font:setFilter("nearest", "nearest")
love.graphics.setFont(font)

SpriteSheet = love.graphics.newImage("assets/spritesheet.png")
SpriteSheet:setFilter("nearest", "nearest")

TileSize = 8
PixelScale = 6
UI = require("ui")

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

function SetBehaviorState(entity, state)
  if DEBUG then print("entity " .. entity.id .. ": " .. state.name) end
  entity.behavior.lastState = entity.behavior.currentState
  entity.behavior.currentState = state
  state.enter(entity)
end

function love.load()
  table.insert(Entities, ResourceNode.create(128, 128))
  table.insert(Entities, ResourceNode.create(600, 128))
  table.insert(Entities, Creature.create(256, 256))
  table.insert(Entities, Creature.create(200, 256))
  UI.init()
end

function love.keypressed(key)
  if key == "escape" then
    DEBUG = not DEBUG
    -- else
    --   if key == "space" then
    --     local e = Entities[1]
    --     if e.behavior.currentState ~= e.behavior.states.hurt then
    --       e.ouch = 1
    --       SetBehaviorState(e, e.behavior.states.hurt)
    --     end
    --   end
  end
end

function love.mousepressed(x, y)
  if DEBUG then print("clicked: ", x, y, math.floor(x / PixelScale), math.floor(y / PixelScale)) end
  for _, e in pairs(Entities) do
    if e.hovered and e.onMouseDown and not e.hidden then e:onMouseDown() end
  end
end

function love.update(dt)
  local scaledDeltaTime = dt * TimeScale

  processMouseHover(Entities)
  processBehaviorStates(Entities, scaledDeltaTime)
  moveEntities(Entities, scaledDeltaTime)
  processEntityUpdate(Entities, scaledDeltaTime)
  processFacing(Entities)
  processAnimations(Entities, scaledDeltaTime)
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 0.5)
  love.graphics.draw(bgImage, 0, 0, 0, PixelScale, PixelScale)

  drawSprites(Entities)
  drawText(Entities)

  love.graphics.print(math.floor(Resource * 10), 8, 8, 0, PixelScale)

  if DEBUG then
    drawHitBoxes(Entities)
    love.graphics.setColor(0, 1, 1)
    for _, e in pairs(Entities) do
      love.graphics.circle("line", e.position.x, e.position.y, 2)
    end
  end
end
