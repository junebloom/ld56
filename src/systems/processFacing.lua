-- Determine sprite facing and animation from input
local function setFacing(entities)
  for _, e in pairs(entities) do
    if e.input then
      if e.input.x > 0 then e.facing = 1 end
      if e.input.x < 0 then e.facing = -1 end
    end
  end
end

return setFacing
