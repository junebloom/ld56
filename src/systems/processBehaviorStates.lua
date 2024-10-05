local function processBehaviorStates(entities, dt)
  for _,e in pairs(entities) do
    if e.behavior ~= nil then
      e.behavior.nextTime = e.behavior.nextTime - dt

      if e.behavior.nextTime <= 0 then
        e.behavior.currentState.exit(e)
      else
        if e.behavior.currentState.update then e.behavior.currentState.update(e, dt) end
      end
    end
  end
end

return processBehaviorStates