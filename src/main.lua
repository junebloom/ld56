dbg = require("utilities.debugger")
Vector = require("utilities.brinevector")

ResourceNode = require("entities.ResourceNode")
Creature = require("entities.Creature")

local processBehaviorActions = require("systems.processBehaviorActions")
local moveEntities = require("systems.moveEntities")
local drawSprites = require("systems.drawSprites")
local drawHitBoxes = require("systems.drawHitboxes")

love.graphics.setBackgroundColor(5/255, 31/255, 57/255)

SpriteSheet = love.graphics.newImage("assets/spritesheet.png")
SpriteSheet:setFilter("nearest", "nearest")

TileSize = 8
PixelScale = 6
entities = {}

local resource = 0

function setEntityState(entity, state)
  entity.behavior.currentState = state
  state.enter(entity)
end

function love.load()
  -- table.insert(entities, ResourceNode.create(128, 128))
  table.insert(entities, ResourceNode.create(256, 128))
  -- table.insert(entities, Creature.create(256, 256))
  table.insert(entities, Creature.create(256, 264))
end

function love.update(dt)
  processBehaviorActions(entities, dt)
  moveEntities(entities, dt)
  -- setAnimationsFromInput(entities, dt)
  -- processAnimations(entities, dt)
end

function love.draw()
  drawSprites(entities)
  drawHitBoxes(entities)
end