local function drawHitBoxes(entities)
  love.graphics.setColor(1, 0, 0)
  for _, e in pairs(entities) do
    if e.hitbox then
      love.graphics.rectangle("line", e.position.x + e.hitbox.offset.x * PixelScale,
        e.position.y + e.hitbox.offset.y * PixelScale, e.hitbox.size
        .x, e.hitbox.size.y)
    end
  end
end

return drawHitBoxes
