local function processEntityUpdate(entities, dt)
  for _, e in pairs(entities) do
    if e.update then e:update(dt) end
  end
end

return processEntityUpdate
