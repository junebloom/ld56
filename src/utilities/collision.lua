function getBounds(entity)
  return {
    left = entity.position.x + entity.hitbox.offset.x,
    right = entity.position.x + entity.hitbox.size.x + entity.hitbox.offset.x,
    top = entity.position.y + entity.hitbox.offset.y,
    bottom = entity.position.y + entity.hitbox.size.y + entity.hitbox.offset.y,
  }
end

function isPointInAABB(point, aabb)
  return point.x > aabb.left and point.x < aabb.right and point.y < aabb.bottom and point.y > aabb.top
end

function isAABBColliding (a, b)
  return a.left < b.right
    and a.right > b.left
    and a.top < b.bottom
    and a.bottom > b.top
end

return {getBounds, isPointInAABB, isAABBColliding}