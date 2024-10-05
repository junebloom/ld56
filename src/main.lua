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
Entities = {}

local resource = 0

function setEntityState(entity, state)
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
  processBehaviorActions(Entities, dt)
  moveEntities(Entities, dt)
  -- setAnimationsFromInput(entities, dt)
  -- processAnimations(entities, dt)
end

function love.draw()
  drawSprites(Entities)
  drawHitBoxes(Entities)
end