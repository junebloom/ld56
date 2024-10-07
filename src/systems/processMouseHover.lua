local collision = require("utilities.collision")

local function processMouseHover(entities)
  local hovering = false

  for _, e in pairs(entities) do
    if e.hitbox then
      local bounds = collision.getBounds(e)
      e.hovered = collision.isPointInAABB(Vector(love.mouse.getPosition()), bounds)
      if e.hovered and not e.hidden then hovering = true end
    end
  end

  if hovering then
    UI.topText.hidden = false
    UI.bottomText.hidden = false
  elseif not UI.isShopOpen then
    UI.topText.hidden = true
    UI.bottomText.hidden = true
  end
end

return processMouseHover
