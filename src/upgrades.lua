local upgrades = {
  MoveSpeedUp = {
    tier = 1,
    available = true,
    glyph = "s+",
    name = "move speed up",
    description = "increase base creature move speed by 50%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed * 1.5
    end
  },
  EfficiencyUp = {
    tier = 1,
    available = true,
    glyph = "hs+",
    name = "harvest speed up",
    description = "double creature's harvest speed",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency * 2
    end
  },
  ProductionUp = {
    tier = 1,
    available = true,
    glyph = "p+",
    name = "production speed up",
    description = "nodes produce 33% faster",
    types = {
      node = true
    },
    apply = function(node)
      node.stats.production = node.stats.production * 2 / 3
    end
  }
}

return upgrades
