local function drawSprites(entities)
  -- love.graphics.setColor(1, 1, 1)
  for _, e in pairs(entities) do
    if e.sprite and not e.hidden then
      local offset = Vector()
      if e.spriteOffset then offset = offset + e.spriteOffset end
      if e.animation and e.animation.offset then offset = offset + e.animation.offset end

      local scale = e.flashing and PixelScale + math.sin(t * 10) * e.flashing or PixelScale

      love.graphics.draw(SpriteSheet, e.sprite, e.position.x, e.position.y, 0, scale * (e.facing or 1), scale,
        -offset.x, -offset.y)
    end
  end
end

return drawSprites
