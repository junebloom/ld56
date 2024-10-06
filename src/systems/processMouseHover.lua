local collision = require("utilities.collision")

local function processMouseHover(entities)
  for _, e in pairs(entities) do
    if e.hitbox then
      local bounds = collision.getBounds(e)
      e.hovered = collision.isPointInAABB(Vector(love.mouse.getPosition()), bounds)
    end
  end
end

return processMouseHover
