local function moveEntities(entities, dt)
  for _,e in pairs(entities) do
    if e.input then
      e.position = e.position + e.input.normalized * e.stats.speed * 50 * dt
    end
  end
end

return moveEntities