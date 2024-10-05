local upgrades = {
  MoveSpeedUpgrade = {
    available = true,
    glyph = "s+",
    name = "speed up",
    description = "increase base creature move speed by 50%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed * 1.5
    end
  }
}

return upgrades
