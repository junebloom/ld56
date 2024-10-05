local function detectCollisions(entities)
  for _,a in pairs(entities) do
    for _,b in pairs(entities) do
      if a ~= b and a.hitbox and b.hitbox then
        if isAABBColliding(getBounds(a), getBounds(b)) then
          -- do something
        end
      end
    end
  end
end

return detectCollisions