local function drawSprites(entities)
  love.graphics.setColor(1,1,1)
  for _,e in pairs(entities) do
    if e.sprite then
      love.graphics.draw(e.sprite, e.position.x, e.position.y, 0, 4 * (e.facing or 1), 4, e.sprite:getWidth() / 2, e.sprite:getHeight())
    end
  end
end

return drawSprites