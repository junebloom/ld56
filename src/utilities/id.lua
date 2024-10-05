local counter = 0

local function new()
  counter = counter + 1
  return counter
end

return { new = new }