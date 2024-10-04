local dbg = require("debugger")
local Vector = require("brinevector")

local entities = {
  player = {
    input = Vector(0, 0),
    position = Vector(0, 0),
    maxSpeed = 200,
    sprite = nil,
    facing = 1,
    frameTime = 0,
    currentFrame = 1,
    animation = nil,
    animations = {
      idle = {
        fps = 6,
        frames = {}
      }
    },
    hitbox = {
      size = Vector(48, 96),
      offset = Vector(-24,-96),
    },
    setAnimation = function(self, animation)
      if self.animation == animation then return end
      self.animation = animation
      self.frameTime = 0
      self.currentFrame = 1
    end
  },
  {
    position = Vector(256, 256),
    hitbox = {
      size = Vector(64, 64),
      offset = Vector(0, 0)
    }
  }
}

-- Utilities

local function getBounds(entity)
  return {
    left = entity.position.x + entity.hitbox.offset.x,
    right = entity.position.x + entity.hitbox.size.x + entity.hitbox.offset.x,
    top = entity.position.y + entity.hitbox.offset.y,
    bottom = entity.position.y + entity.hitbox.size.y + entity.hitbox.offset.y,
  }
end

local function isPointInAABB(point, aabb)
  return point.x > aabb.left and point.x < aabb.right and point.y < aabb.bottom and point.y > aabb.top
end

local function isAABBColliding (a, b)
  return a.left < b.right
    and a.right > b.left
    and a.top < b.bottom
    and a.bottom > b.top
end

-- Systems

local function moveEntities(entities, dt)
  for _,e in pairs(entities) do
    if e.input then
      e.position = e.position + e.input.normalized * e.maxSpeed * dt
    end
  end
end

local function detectCollisions(entities)
  for _,a in pairs(entities) do
    for _,b in pairs(entities) do
      if a ~= b and a.hitbox and b.hitbox then
        if isAABBColliding(getBounds(a), getBounds(b)) then
          -- do something
        end
      end
    end
  end
end

-- Determine sprite facing and animation from input
local function setAnimationsFromInput(entities)
  for _,e in pairs(entities) do
    if e.input then
      if e.input.x > 0 then e.facing = 1 end
      if e.input.x < 0 then e.facing = -1 end

      if e.animations then
        if e.input.x == 0 and e.input.y == 0 then
          e:setAnimation(e.animations.idle)
        else
          e:setAnimation(e.animations.walk)
        end
      end
    end
  end
end

-- Update sprite animation frames
local function processAnimations(entities, dt)
  for _,e in pairs(entities) do
    if e.animations then
      e.frameTime = e.frameTime + dt

      if (e.frameTime >= 1 / e.animation.fps) then
        e.currentFrame = e.currentFrame + 1
        e.frameTime = 0
      end

      if (e.currentFrame > #e.animation.frames) then
        e.currentFrame = 1
      end

      e.sprite = e.animation.frames[e.currentFrame]
    end
  end
end

function drawSprites()
  love.graphics.setColor(1,1,1)
  for _,e in pairs(entities) do
    if e.sprite then
      love.graphics.draw(e.sprite, e.position.x, e.position.y, 0, 4 * (e.facing or 1), 4, e.sprite:getWidth() / 2, e.sprite:getHeight())
    end
  end
end

function drawHitBoxes()
  love.graphics.setColor(1,0,0)
  for _,e in pairs(entities) do
    if e.hitbox then
      love.graphics.rectangle("line", e.position.x + e.hitbox.offset.x, e.position.y + e.hitbox.offset.y, e.hitbox.size.x, e.hitbox.size.y)
    end
  end
end

-- Love callbacks

function love.load()
  for _,animation in pairs(entities.player.animations) do
    for _,frame in pairs(animation.frames) do
      frame:setFilter("nearest", "nearest")
    end
  end
end

function love.update(dt)
  -- Construct player input vector
  entities.player.input = Vector(0, 0)
  if love.keyboard.isDown("d") then entities.player.input.x = entities.player.input.x + 1 end
  if love.keyboard.isDown("a") then entities.player.input.x = entities.player.input.x - 1 end
  if love.keyboard.isDown("s") then entities.player.input.y = entities.player.input.y + 1 end
  if love.keyboard.isDown("w") then entities.player.input.y = entities.player.input.y - 1 end

  moveEntities(entities, dt)
  detectCollisions(entities, dt)
  -- setAnimationsFromInput(entities, dt)
  -- processAnimations(entities, dt)
end

function love.draw()
  drawSprites()  
  drawHitBoxes()
end