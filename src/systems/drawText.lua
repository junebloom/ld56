local function drawText(entities)
  love.graphics.setColor(1, 1, 1)
  for _, e in pairs(entities) do
    if e.text then
      love.graphics.printf(e.text, e.position.x, e.position.y, 128, "center", 0, PixelScale, PixelScale, 64, 3)
    end
  end
end

return drawText
