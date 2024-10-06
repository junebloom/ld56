-- Import utilities
dbg = require("utilities.debugger")
Vector = require("utilities.brinevector")
ID = require("utilities.id")

-- Import entities
ResourceNode = require("entities.ResourceNode")
StatNode = require("entities.StatNode")
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
CreatureTier = 1
GrowthThresholds = {
  smart = { 2, 5, 10 },
  scary = { 2, 5, 10 },
  power = { 2, 5, 10 }
}

Upgrades = require("upgrades")
UpgradeCosts = { 1, 3, 9 }
PurchasedUpgrades = {}

function CheckGrowthThresholds(creature)
  local shouldGrow = true

  for stat, thresholds in pairs(GrowthThresholds) do
    if creature.stats[stat] < thresholds[CreatureTier] then
      shouldGrow = false
    end
  end

  if shouldGrow then
    if DEBUG then print("Thresholds reached -- going up a tier!") end
    CreatureTier = CreatureTier + 1
  end
end

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

function ApplyUpgradeToEntities(upgrade, arg)
  for _, e in pairs(Entities) do
    if upgrade.types[e.type] then upgrade.apply(e, arg) end
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
  table.insert(Entities, StatNode.create(600, 128, "scary"))

  table.insert(Entities, Creature.create(256, 256))
  table.insert(Entities, Creature.create(200, 256))
  UI.init()
end

function love.keypressed(key)
  if key == "escape" then DEBUG = not DEBUG end
  if DEBUG then
    if key == "tab" then
      TimeScale = 0
      print("\n!! Pausing and opening debugger !!")
      dbg()
      print("!! Remember to unpause after closing !!")
    end
    if key == "0" then TimeScale = 0 end
    if key == "1" then TimeScale = 1 end
    if key == "2" then TimeScale = 3 end
    if key == "3" then TimeScale = 5 end
    if key == "4" then TimeScale = 10 end
    if key == "5" then TimeScale = 20 end
  end
  -- else
  --   if key == "space" then
  --     local e = Entities[1]
  --     if e.behavior.currentState ~= e.behavior.states.hurt then
  --       e.ouch = 1
  --       SetBehaviorState(e, e.behavior.states.hurt)
  --     end
  --   end
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

  if (TimeScale == 0) then love.graphics.print("paused", 53 * PixelScale, 8, 0, PixelScale) end

  if DEBUG then
    drawHitBoxes(Entities)
    love.graphics.setColor(0, 1, 1)
    for _, e in pairs(Entities) do
      love.graphics.circle("line", e.position.x, e.position.y, 2)
    end
  end
end
