-- Update sprite animation frames
local function processAnimations(entities, dt)
  for _, e in pairs(entities) do
    if e.animation then
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

return processAnimations
