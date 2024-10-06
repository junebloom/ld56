local upgrades = {

  -- Creature Upgrades

  -- Tier 1

  MoveSpeedUp = {
    tier = 1,
    available = true,
    glyph = "ms+",
    name = "move speed up",
    description = "increase base creature move speed by 50%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed + 0.5
    end
  },
  PowerGrowthUp = {
    tier = 1,
    available = true,
    glyph = "se",
    name = "strength efficiency",
    description = "creatures gain 50% more strength",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.powerGrowthMulti = creature.stats.powerGrowthMulti + 0.5
      Upgrades.PowerGrowthUp.available = false
    end
  },
  ScaryGrowthUp = {
    tier = 1,
    available = true,
    glyph = "fe",
    name = "fear efficiency",
    description = "creatures gain 50% more spookiness",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.scaryGrowthMulti = creature.stats.scaryGrowthMulti + 0.5
      Upgrades.ScaryGrowthUp.available = false
    end
  },
  SmartGrowthUp = {
    tier = 1,
    available = true,
    glyph = "se",
    name = "strength efficiency",
    description = "creatures gain 50% more strength",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smartGrowthMulti = creature.stats.smartGrowthMulti + 0.5
      Upgrades.SmartGrowthUp.available = false
    end
  },
  MoveSpeedMulti = {
    tier = 1,
    available = true,
    glyph = "ms*",
    name = "move speed up",
    description = "multiply current move speed by 120%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed * 1.2
      Upgrades.MoveSpeedMulti.available = false
    end
  },
  EfficiencyUp = {
    tier = 1,
    available = true,
    glyph = "hs",
    name = "harvest speed up",
    description = "harvest effiiciency increased",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency + 1
    end
  },
  ProductionUp = {
    tier = 1,
    available = true,
    glyph = "p+",
    name = "production speed up",
    description = "resource nodes produce 25% faster",
    types = {
      resourceNode = true,
      statNode = true
    },
    apply = function(node)
      node.stats.production = node.stats.production * 1.5
    end
  },
  SmartUp = {
    tier = 1,
    available = true,
    glyph = "f+",
    name = "focus up",
    description = "creatures idle and wander a little less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smart = creature.stats.smart + 8
      Upgrades.SmartUp.available = false
      Upgrades.SmartUpT2.available = true
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
      Upgrades.DefenseUpT2.available = true
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

  -- Tier 2

  SmartUpT2 = {
    tier = 2,
    available = false,
    glyph = "f++",
    name = "focus up +",
    description = "creatures idle and wander less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smart = creature.stats.smart + 16
      Upgrades.SmartUpT2.available = false
      Upgrades.SmartUpT3.prereq = true
    end
  },
  DefenseUpT2 = {
    tier = 2,
    available = false,
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

  -- Tier 3

  DefenseUpT3 = {
    tier = 3,
    available = false,
    glyph = "d+",
    name = "defense up",
    description = "improve defense by an additional 100%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.defense = creature.stats.defense + 1
      Upgrades.DefenseUpT3.available = false
    end
  },
  SmartUpT3 = {
    tier = 3,
    available = false,
    glyph = "f++",
    name = "focus up +",
    description = "creatures idle and wander a lot less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smart = creature.stats.smart + 24
      Upgrades.SmartUpT2.available = false
    end
  },

  -- ResourceNode Upgrades

  LooshNodeT1 = {
    tier = 1,
    available = false,
    glyph = "l+",
    name = "loosh node lv 2",
    description = "greatly increase loosh node production amount and required harvest time",
    types = {
      resourceNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.LooshNodeT1.available = false
    end
  },
  LooshNodeT2 = {
    tier = 2,
    available = false,
    glyph = "l+",
    name = "loosh node lv 2",
    description = "greatly increase loosh node production amount and required harvest time",
    types = {
      resourceNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.LooshNodeT2.available = false
    end
  },
  LooshNodeT3 = {
    tier = 3,
    available = false,
    glyph = "l++",
    name = "loosh node lv 3",
    description = "greatly increase loosh node production amount and required harvest time",
    types = {
      resourceNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 3
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.LooshNodeT3.available = false
    end
  },

  -- Growth

  AllGrowthUp = {
    tier = "Growth",
    available = true,
    glyph = "vp",
    name = "vast potential",
    description = "base creature growth speed increased by 100%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.overallGrowthMulti = creature.stats.overallGrowthMulti + 1
      Upgrades.AllGrowthUp.available = false
    end
  },

  -- SmartUpGrowth = {
  --   tier = "Growth",
  --   available = false,
  --   glyph = "-hf-",
  --   name = "hyperfocus",
  --   description = "creatures idle for far less time",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --     creature.stats.smart = creature.stats.smart + 9
  --     Upgrades.SmartUpGrowth.available = false
  --   end
  -- },

  --PackTactics = {
  --  tier = "Growth",
  --  available = true,
  --  repeatable = true,
  --  glyph = "PT",
  --  name = "Pack Tactics",
  --  description = "an extra creature is created",
  --  types = {
  --  },
  --  apply = function(creature)
  --    creature.create(128,128)
  --  end
  --},

  -- Non-player facing upgrades for growth stat harvesting
  HarvestGrowthStat = {
    smart = {
      tier = 1,
      available = false,
      repeatable = false,
      prereq = false,
      glyph = "nope",
      name = "grow smart up",
      description = "smart",
      types = {
        creature = true
      },
      apply = function(creature)
        creature.stats.smart = creature.stats.smart + 24
        CheckGrowthThresholds(creature)
      end
    },
    scary = {
      tier = 1,
      available = false,
      repeatable = false,
      prereq = false,
      glyph = "nope",
      name = "grow scary up",
      description = "scary",
      types = {
        creature = true
      },
      apply = function(creature)
        creature.stats.scary = creature.stats.scary + 24
        CheckGrowthThresholds(creature)
      end
    },
    power = {
      tier = 1,
      available = false,
      repeatable = false,
      prereq = false,
      glyph = "nope",
      name = "grow power up",
      description = "power",
      types = {
        creature = true
      },
      apply = function(creature)
        creature.stats.power = creature.stats.power + 24
        CheckGrowthThresholds(creature)
      end
    },
  }
}

return upgrades
