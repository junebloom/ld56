local function drawText(entities)
  love.graphics.setFont(Font)
  -- love.graphics.setColor(1, 1, 1)
  for _, e in pairs(entities) do
    if e.text and not e.hidden then
      local scale = e.flashing and PixelScale + math.sin(t * 10) * 0.5 or PixelScale

      love.graphics.printf(e.text, e.position.x, e.position.y, 128, "center", 0, scale, scale, 64, 3)
    end
  end
end

return drawText
