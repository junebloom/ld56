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
DoomClock = 100 -- TODO: game end state
Entities = {}

Resource = 2.5
CreatureTier = 1
GrowthThresholds = {
  smart = { 2, 5, 10 },
  scary = { 2, 5, 10 },
  power = { 2, 5, 10 }
}

-- Base passive stat gain per second
BasePassive = {
  loosh = 0.05,
  smart = 0.01,
  scary = 0.01,
  power = 0.01
}

Upgrades = require("upgrades")
UpgradeCosts = { 1, 3, 9 }
PurchasedUpgrades = {}

NodePoints = {
  Vector(29, 29),
  Vector(50, 21),
  Vector(70, 30),
  Vector(92, 25),
  Vector(64, 48),
  Vector(112, 43),
  Vector(96, 75),
  Vector(76, 66),
  Vector(70, 76),
  Vector(48, 78),
  Vector(22, 67),
  Vector(46, 55)
}

-- Configure graphics
Colors = {
  { 5 / 255,   31 / 255,  57 / 255 },
  { 29 / 255,  21 / 255,  89 / 255 },
  { 74 / 255,  36 / 255,  128 / 255 },
  { 197 / 255, 58 / 255,  157 / 255 },
  { 244 / 255, 142 / 255, 128 / 255 },
}
love.graphics.setBackgroundColor(Colors[1])
local bgStars = love.graphics.newImage("assets/stars.png")
local bgPlanet = love.graphics.newImage("assets/planet.png")
bgStars:setFilter("nearest", "nearest")
bgPlanet:setFilter("nearest", "nearest")

Font = love.graphics.newImageFont("assets/font.png", "abcdefghijklmnopqrstuvwxyz0123456789+-%*/.: ")
Font:setFilter("nearest", "nearest")

SpriteSheet = love.graphics.newImage("assets/spritesheet.png")
SpriteSheet:setFilter("nearest", "nearest")

TileSize = 8
PixelScale = 6
UI = require("ui")

-- Global functions

function CheckGrowthThresholds(creature)
  local newTier = 4

  -- Find the creature's lowest tier stat
  for stat, thresholds in pairs(GrowthThresholds) do
    for i = 3, 1, -1 do
      if creature.stats[stat] < thresholds[i] and i < newTier then
        newTier = i
      end
    end
  end

  if CreatureTier ~= newTier then
    if DEBUG then print("Moving to tier: " .. newTier) end

    creature.flashing = 2
    CreatureTier = newTier
    DoomClock = DoomClock + 60
  end
end

function GetStatTier(n)
  local tier = 1
  for i = 3, 1, -1 do
    if n >= GrowthThresholds.smart[i] then tier = i + 1 end
  end
  return tier
end

function GetUpgradeChoices(tier)
  local availableUpgrades = {}
  for _, upgrade in pairs(Upgrades) do
    if upgrade.tier == tier and upgrade.available then
      if DEBUG then print(upgrade.name) end
      table.insert(availableUpgrades, upgrade)
    end
  end

  local choices = {}
  for i = 1, 3 do
    if #availableUpgrades == 0 then
      table.insert(choices, Upgrades.SoldOutUpgrade)
    else
      local n = math.random(#availableUpgrades)
      table.insert(choices, availableUpgrades[n])
      table.remove(availableUpgrades, n)
    end
  end

  return choices
end

function ApplyUpgradeToEntities(upgrade, arg)
  for _, e in pairs(Entities) do
    if upgrade.types[e.type] then upgrade.apply(e, arg) end
  end
end

function SetBehaviorState(entity, state)
  if DEBUG then print("entity " .. entity.id .. ": " .. state.name) end
  entity.behavior.lastState = entity.behavior.currentState
  entity.behavior.currentState = state
  state.enter(entity)
end

-- Love callbacks

local debugFont = love.graphics.newFont(16)
DebugCreature = {}

function love.load()
  math.randomseed(os.time())

  local n = math.random(#NodePoints)
  table.insert(Entities, ResourceNode.create(NodePoints[n].x * PixelScale, NodePoints[n].y * PixelScale))
  table.remove(NodePoints, n)

  local n = math.random(#NodePoints)
  table.insert(Entities, StatNode.create(NodePoints[n].x * PixelScale, NodePoints[n].y * PixelScale, "smart"))
  table.remove(NodePoints, n)

  local n = math.random(#NodePoints)
  table.insert(Entities, StatNode.create(NodePoints[n].x * PixelScale, NodePoints[n].y * PixelScale, "scary"))
  table.remove(NodePoints, n)

  local n = math.random(#NodePoints)
  table.insert(Entities, StatNode.create(NodePoints[n].x * PixelScale, NodePoints[n].y * PixelScale, "power"))
  table.remove(NodePoints, n)

  DebugCreature = Creature.create(64 * PixelScale, 64 * PixelScale)
  table.insert(Entities, DebugCreature)

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

    if key == "s" then
      table.insert(Entities, Creature.create(64 * PixelScale, 64 * PixelScale))
    end
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

-- internal game clock
t = 0

function love.update(dt)
  t = t + dt
  local scaledDeltaTime = dt * TimeScale

  DoomClock = DoomClock - scaledDeltaTime
  SmoothClock = SmoothClock + ((DoomClock - SmoothClock) * dt)

  Resource = Resource + BasePassive.loosh * DebugCreature.stats.greed * scaledDeltaTime

  processMouseHover(Entities)
  processBehaviorStates(Entities, scaledDeltaTime)
  moveEntities(Entities, scaledDeltaTime)
  processEntityUpdate(Entities, scaledDeltaTime)
  processFacing(Entities)
  processAnimations(Entities, dt)
end

SmoothClock = DoomClock

function love.draw()
  local bgProgress = 1 - SmoothClock / 100
  local bgEasing = 1 - math.sqrt(1 - bgProgress ^ 2)
  local bgScale = PixelScale - 1 + bgEasing * 3

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(bgStars, 0, 0, -0.2, PixelScale, PixelScale, 72, 32)
  love.graphics.draw(bgPlanet, 64, 0, -0.1, bgScale, bgScale, 128, 64)

  drawSprites(Entities)
  drawText(Entities)

  local looshString = math.floor(Resource * 10) .. " loosh"

  love.graphics.printf(looshString, 0, 88 * PixelScale, 128, "right", 0, PixelScale)
  love.graphics.printf("t-" .. math.floor(SmoothClock), 0, 1 * PixelScale, 128, "center", 0, PixelScale)
  love.graphics.printf("tier" .. CreatureTier, 0, 1 * PixelScale, 128, "right", 0, PixelScale)


  for stat, bar in pairs(UI.statBars) do
    bar.hitbox.size.x = PixelScale + 128 * math.min(DebugCreature.stats[stat], 10) / 10

    love.graphics.setColor(bar.color)
    love.graphics.rectangle("fill", bar.position.x, bar.position.y, bar.hitbox.size.x, bar.hitbox.size.y)
  end

  if (TimeScale == 0) then love.graphics.printf("paused", 0, 16 * PixelScale, 128, "center", 0, PixelScale) end

  if DEBUG then
    drawHitBoxes(Entities)

    love.graphics.setColor(0, 1, 1)
    for _, e in pairs(Entities) do
      love.graphics.circle("line", e.position.x, e.position.y, 2)
    end

    love.graphics.setFont(debugFont)
    love.graphics.print("smart: " .. DebugCreature.stats.smart, 0, 0)
    love.graphics.print("scary: " .. DebugCreature.stats.scary, 0, 16)
    love.graphics.print("power: " .. DebugCreature.stats.power, 0, 32)
    love.graphics.print("tier: " .. CreatureTier, 0, 48)
    love.graphics.print("fps: " .. love.timer.getFPS(), 0, 64)
    -- love.graphics.print("doom: " .. DoomClock, 0, 80)
  end
end
