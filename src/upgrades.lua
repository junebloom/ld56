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
  },
  SmartUp = {
    tier = 1,
    available = true,
    glyph = "f+",
    name = "focus up",
    description = "creatures idle for less time",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smart = creature.stats.smart + 3
      Upgrades.SmartUp.available = false
    end
  },
  DefenseUp = {
    tier = 1,
    available = true,
    glyph = "d+",
    name = "defense up",
    description = "improve defense by 100%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.defense = creature.stats.defense + 1
      Upgrades.DefenseUp.available = false
    end
  },
  GreedUp = {
    tier = 1,
    available = true,
    glyph = "g+",
    name = "resourceful",
    description = "harvesting is worth 20% more",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.greed = creature.stats.greed * 1.2
      Upgrades.GreedUp.available = false
    end
  },
  LooshNodeTier2 = {
    tier = 1,
    available = true,
    glyph = "t2",
    name = "loosh node lv 2",
    description = "increase the tier of all loosh nodes",
    types = {
      node = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 2
      Upgrades.LooshNodeTier2.available = false
    end
  },
}

return upgrades
