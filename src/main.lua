dbg = require("utilities.debugger")
Vector = require("utilities.brinevector")

ResourceNode = require("entities.ResourceNode")
Creature = require("entities.Creature")

local processBehaviorActions = require("systems.processBehaviorActions")
local moveEntities = require("systems.moveEntities")
local drawHitBoxes = require("systems.drawHitboxes")

pixelScale = 6
entities = {}

local resource = 0

function setEntityState(entity, state)
  state.enter(entity)
  entity.behavior.currentState = state
end

function love.load()
  -- TODO: Fix this
  -- for _,animation in pairs(entities.creature.animations) do
  --   for _,frame in pairs(animation.frames) do
  --     frame:setFilter("nearest", "nearest")
  --   end
  -- end

  table.insert(entities, ResourceNode.create(128, 128))
  table.insert(entities, Creature.create(256, 256))
end

function love.update(dt)
  processBehaviorActions(entities, dt)
  moveEntities(entities, dt)
  -- setAnimationsFromInput(entities, dt)
  -- processAnimations(entities, dt)
end

function love.draw()
  -- drawSprites()
  drawHitBoxes(entities)
end