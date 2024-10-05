local function drawHitBoxes(entities)
  love.graphics.setColor(1,0,0)
  for _,e in pairs(entities) do
    if e.hitbox then
      love.graphics.rectangle("line", e.position.x + e.hitbox.offset.x, e.position.y + e.hitbox.offset.y, e.hitbox.size.x, e.hitbox.size.y)
    end
  end
end

return drawHitBoxes