local function drawSprites(entities)
  love.graphics.setColor(1,1,1)
  for _,e in pairs(entities) do
    if e.sprite then
      love.graphics.draw(SpriteSheet, e.sprite, e.position.x, e.position.y, 0, PixelScale * (e.facing or 1), PixelScale, e.spriteOffset.x, e.spriteOffset.y)
    end
  end
end

return drawSprites