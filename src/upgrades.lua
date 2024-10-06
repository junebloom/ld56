local upgrades = {
  MoveSpeedUp = {
    tier = 1,
    available = true,
    repeatable = true,
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
  MoveSpeedMulti = {
    tier = 1,
    available = true,
    repeatable = false,
    glyph = "ms*",
    name = "move speed up",
    description = "multiply current move speed by 120%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed * 1.2
      Upgrades.DefenseUp.available = false
    end
  },
  EfficiencyUp = {
    tier = 1,
    available = true,
    repeatable = true,
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
    repeatable = true,
    glyph = "p+",
    name = "production speed up",
    description = "nodes produce 25% faster",
    types = {
      resourceNode = true
    },
    apply = function(node)
      node.stats.production = node.stats.production * 3 / 4
    end
  },
  SmartUp = {
    tier = 1,
    available = true,
    repeatable = false,
    glyph = "f+",
    name = "focus up",
    description = "creatures idle and wander a little less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smart = creature.stats.smart + 8
      Upgrades.SmartUp.available = false
      Upgrades.SmartUpT2.prereq = true
    end
  },
  DefenseUp = {
    tier = 1,
    available = true,
    repeatable = false,
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
    repeatable = false,
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
    repeatable = false,
    glyph = "t2",
    name = "loosh node lv 2",
    description = "increase the tier of all loosh nodes",
    types = {
      resourceNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      Upgrades.LooshNodeTier2.available = false
    end
  },




  -- Tier 2

  SmartUpT2 = {
    tier = 2,
    available = false,
    repeatable = false,
    prereq = false,
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
    repeatable = false,
    prereq = false,
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
    repeatable = false,
    prereq = false,
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
    repeatable = false,
    prereq = false,
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


  -- Growth

  -- SmartUpGrowth = {
  --   tier = "Growth",
  --   available = false,
  --   repeatable = false,
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
}

return upgrades
