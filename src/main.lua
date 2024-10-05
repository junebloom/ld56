dbg = require("utilities.debugger")
Vector = require("utilities.brinevector")
ID = require("utilities.id")

ResourceNode = require("entities.ResourceNode")
Creature = require("entities.Creature")

local processBehaviorStates = require("systems.processBehaviorStates")
local moveEntities = require("systems.moveEntities")
local drawSprites = require("systems.drawSprites")
local drawHitBoxes = require("systems.drawHitboxes")

love.graphics.setBackgroundColor(5/255, 31/255, 57/255)

SpriteSheet = love.graphics.newImage("assets/spritesheet.png")
SpriteSheet:setFilter("nearest", "nearest")

Font = love.graphics.newImageFont("assets/font.png", "abcdefghijklmnopqrstuvwxyz0123456789+-%*/.: ")
Font:setFilter("nearest", "nearest")
love.graphics.setFont(Font)

TileSize = 8
PixelScale = 6

Entities = {}
Resource = 0

DEBUG = true

function setBehaviorState(entity, state)
  if DEBUG then print("entity "..entity.id..": "..state.name) end
  entity.behavior.currentState = state
  state.enter(entity)
end

function love.load()
  table.insert(Entities, ResourceNode.create(128, 128))
  table.insert(Entities, ResourceNode.create(256, 128))
  table.insert(Entities, Creature.create(256, 256))
  table.insert(Entities, Creature.create(200, 256))
end

function love.update(dt)
  processBehaviorStates(Entities, dt)
  moveEntities(Entities, dt)
  -- setAnimationsFromInput(entities, dt)
  -- processAnimations(entities, dt)
end

function love.draw()
  drawSprites(Entities)
  love.graphics.print("resource:"..Resource, 32, 32, 0, PixelScale, PixelScale)
  if DEBUG then drawHitBoxes(Entities) end
end