local function drawHitBoxes(entities)
  for _, e in pairs(entities) do
    if e.hitbox then
      if e.hovered then
        love.graphics.setColor(0, 1, 0)
      else
        love.graphics.setColor(1, 0, 0)
      end

      love.graphics.rectangle("line", e.position.x + e.hitbox.offset.x,
        e.position.y + e.hitbox.offset.y, e.hitbox.size
        .x, e.hitbox.size.y)
    end
  end
end

return drawHitBoxes
