local upgrades = {

  -- TODO: As above for growth stats/per creature? Maybe lower global growthmulti to compensate
  -- for each creature base passive growth increase by 50% but overall growth decreases by 5%

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
      Upgrades.MoveSpeedUp.available = false
    end
  },

  PowerGrowthUp = {
    tier = 1,
    available = true,
    glyph = "se+",
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
    glyph = "fe+",
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
    glyph = "ce+",
    name = "cunning efficiency",
    description = "creatures gain 50% more smarts",
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
    glyph = "hs+",
    name = "harvest speed up +",
    description = "base harvest speed increased by 50%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency + 0.5
      Upgrades.EfficiencyUp.available = false
    end
  },

  EfficiencyMulti = {
    tier = 1,
    available = true,
    glyph = "qw*",
    name = "quick worker",
    description = "current harvest speed doubled",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency * 2
      Upgrades.EfficiencyMulti.available = false
    end
  },

  FocusUp = {
    tier = 1,
    available = true,
    glyph = "f+",
    name = "focus up +",
    description = "creatures idle and wander a little less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.focus = creature.stats.focus + 15
      Upgrades.FocusUp.available = false
      Upgrades.FocusUpT2.available = true
    end
  },

  -- DefenseUp = {
  --   tier = 1,
  --   available = true,
  --   glyph = "d+",
  --   name = "defense up",
  --   description = "improve defense by 100%",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --     creature.stats.defense = creature.stats.defense + 1
  --     Upgrades.DefenseUp.available = false
  --     Upgrades.DefenseUpT2.available = true
  --   end
  -- },

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
      creature.stats.greed = creature.stats.greed + 0.2
      Upgrades.GreedUp.available = false
      Upgrades.GreedUpT2.available = true
    end
  },

  -- Tier 2

  MoveSpeedUpT2 = {
    tier = 2,
    available = true,
    glyph = "ms++",
    name = "move speed up ++",
    description = "increase base creature move speed by 100%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed + 1
      Upgrades.MoveSpeedUpT2.available = false
    end
  },

  PowerGrowthUpT2 = {
    tier = 2,
    available = true,
    glyph = "se++",
    name = "strength efficiency++",
    description = "creatures gain 100% more strength",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.powerGrowthMulti = creature.stats.powerGrowthMulti + 1
      Upgrades.PowerGrowthUpT2.available = false
    end
  },

  ScaryGrowthUpT2 = {
    tier = 2,
    available = true,
    glyph = "fe++",
    name = "fear efficiency++",
    description = "creatures gain 100% more spookiness",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.scaryGrowthMulti = creature.stats.scaryGrowthMulti + 1
      Upgrades.ScaryGrowthUpT2.available = false
    end
  },

  SmartGrowthUpT2 = {
    tier = 2,
    available = true,
    glyph = "ce++",
    name = "cunning efficiency ++",
    description = "creatures gain 100% more smarts",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smartGrowthMulti = creature.stats.smartGrowthMulti + 1
      Upgrades.SmartGrowthUpT2.available = false
    end
  },

  MoveSpeedMultiT2 = {
    tier = 2,
    available = true,
    glyph = "ms*",
    name = "move speed up ++",
    description = "multiply current move speed by 140%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed * 1.4
      Upgrades.MoveSpeedMultiT2.available = false
    end
  },

  EfficiencyUpT2 = {
    tier = 2,
    available = true,
    glyph = "hs++",
    name = "harvest speed up ++",
    description = "base harvest speed increased by 100%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency + 1
      Upgrades.EfficiencyUpT2.available = false
    end
  },

  EfficiencyMultiT2 = {
    tier = 2,
    available = true,
    glyph = "qw++",
    name = "quick worker ++",
    description = "harvest efficiency doubled",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency * 2
      Upgrades.EfficiencyMultiT2.available = false
    end
  },

  FocusUpT2 = {
    tier = 2,
    available = false,
    glyph = "f++",
    name = "focus up ++",
    description = "creatures idle and wander less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.focus = creature.stats.focus + 33
      Upgrades.FocusUpT2.available = false
      Upgrades.FocusUpT3.prereq = true
    end
  },

  -- DefenseUpT2 = {
  --   tier = 2,
  --   available = false,
  --   glyph = "d++",
  --   name = "defense up ++",
  --   description = "improve defense by 100%",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --     creature.stats.defense = creature.stats.defense + 1
  --     Upgrades.DefenseUp.available = false
  --   end
  -- },

  GreedUpT2 = {
    tier = 2,
    available = false,
    glyph = "g++",
    name = "resourceful++",
    description = "harvesting is worth 30% more",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.greed = creature.stats.greed + 0.3
      Upgrades.GreedUpT2.available = false
      Upgrades.GreedUpT3.available = true
    end
  },

  -- Tier 3

  MoveSpeedUpT3 = {
    tier = 3,
    available = true,
    glyph = "+ms+",
    name = "move speed up +++",
    description = "increase base creature move speed by 150%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed + 1.5
      Upgrades.MoveSpeedUpT3.available = false
    end
  },

  PowerGrowthUpT3 = {
    tier = 3,
    available = true,
    glyph = "+se+",
    name = "strength efficiency+++",
    description = "creatures gain 150% more strength",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.powerGrowthMulti = creature.stats.powerGrowthMulti + 1.5
      Upgrades.PowerGrowthUpT3.available = false
    end
  },

  ScaryGrowthUpT3 = {
    tier = 3,
    available = true,
    glyph = "+fe+",
    name = "fear efficiency +++",
    description = "creatures gain 150% more spookiness",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.scaryGrowthMulti = creature.stats.scaryGrowthMulti + 1.5
      Upgrades.ScaryGrowthUpT3.available = false
    end
  },

  SmartGrowthUpT3 = {
    tier = 3,
    available = true,
    glyph = "+ce+",
    name = "cunning efficiency +++",
    description = "creatures gain 150% more smarts",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.smartGrowthMulti = creature.stats.smartGrowthMulti + 1.5
      Upgrades.SmartGrowthUpT3.available = false
    end
  },

  MoveSpeedMultiT3 = {
    tier = 3,
    available = true,
    glyph = "*ms*",
    name = "move speed up +++",
    description = "multiply current move speed by 140%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.moveSpeed = creature.stats.moveSpeed * 1.4
      Upgrades.MoveSpeedMultiT3.available = false
    end
  },

  EfficiencyUpT3 = {
    tier = 3,
    available = true,
    glyph = "+hs+",
    name = "harvest speed up +++",
    description = "base harvest speed increased by 200%",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency + 2
      Upgrades.EfficiencyUpT3.available = false
    end
  },

  EfficiencyMultiT3 = {
    tier = 3,
    available = true,
    glyph = "+qw+",
    name = "quick worker +++",
    description = "harvest efficiency doubled",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.efficiency = creature.stats.efficiency * 2
      Upgrades.EfficiencyMultiT3.available = false
    end
  },

  -- DefenseUpT3 = {
  --   tier = 3,
  --   available = false,
  --   glyph = "+d+",
  --   name = "defense up +++",
  --   description = "improve defense by an additional 100%",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --     creature.stats.defense = creature.stats.defense + 1
  --     Upgrades.DefenseUpT3.available = false
  --   end
  -- },

  FocusUpT3 = {
    tier = 3,
    available = false,
    glyph = "+f+",
    name = "focus up +++",
    description = "creatures idle and wander a lot less",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.focus = creature.stats.focus + 51
      Upgrades.FocusUpT3.available = false
    end
  },

  GreedUpT3 = {
    tier = 3,
    available = false,
    glyph = "+g+",
    name = "resourceful+++",
    description = "harvesting is worth 40% more",
    types = {
      creature = true
    },
    apply = function(creature)
      creature.stats.greed = creature.stats.greed + 0.4
      Upgrades.GreedUpT3.available = false
    end
  },

  -- Node Upgrades


  PassiveLooseNode = {
    tier = 1,
    available = true,
    glyph = "ll",
    name = "leaking loosh",
    description = "loosh vents passively produce 1 loosh every 40 seconds",
    types = {
      resourceNode = true
    },
    apply = function(node)
      BasePassive.loosh = BasePassive.loosh + 0.025
      Upgrades.PassiveLooseNode.available = false
      Upgrades.PassiveLooseNodeT2.available = true
    end
  },

  PassiveLooseNodeT2 = {
    tier = 2,
    available = false,
    glyph = "ll+",
    name = "leaking loosh +",
    description = "loosh vents passively produce an additional loosh every 20 seconds",
    types = {
      resourceNode = true
    },
    apply = function(node)
      BasePassive.loosh = BasePassive.loosh + 0.05
      Upgrades.PassiveLooseNodeT2.available = false
      Upgrades.PassiveLooseNodeT3.available = true
    end
  },

  PassiveLooseNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+ll+",
    name = "leaking loosh ++",
    description = "loosh vents passively produce 1 loosh every 10 seconds",
    types = {
      resourceNode = true
    },
    apply = function(node)
      BasePassive.loosh = BasePassive.loosh + 0.1
      Upgrades.PassiveLooseNodeT3.available = false
    end
  },

  PassiveSmartNode = {
    tier = 1,
    available = true,
    glyph = "oz",
    name = "oozing intellect",
    description = "fungal brains passively produce additional smarts over every 20 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "smart" then
        BasePassive.smart = BasePassive.smart + 0.05
      end
      Upgrades.PassiveSmartNode.available = false
      Upgrades.PassiveSmartNodeT2.available = true
    end
  },

  PassiveSmartNodeT2 = {
    tier = 2,
    available = false,
    glyph = "oz+",
    name = "oozing intellect+",
    description = "fungal brains passively produce additional smarts over every 10 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "smart" then
        BasePassive.smart = BasePassive.smart + 0.1
      end
      Upgrades.PassiveSmartNodeT2.available = false
      Upgrades.PassiveSmartNodeT3.available = true
    end
  },

  PassiveSmartNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+oz+",
    name = "oozing intellect",
    description = "fungal brains passively produce additional smarts over every 5 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "smart" then
        BasePassive.smart = BasePassive.smart + 0.2
      end
      Upgrades.PassiveSmartNodeT3.available = false
    end
  },

  PassiveStrongNode = {
    tier = 1,
    available = true,
    glyph = "um",
    name = "universal might",
    description = "cosmic vessels passively strengthen creatures every 20 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "strong" then
        BasePassive.strong = BasePassive.strong + 0.05
      end
      Upgrades.PassiveStrongNode.available = false
      Upgrades.PassiveStrongNodeT2.available = true
    end
  },

  PassiveStrongNodeT2 = {
    tier = 2,
    available = false,
    glyph = "um+",
    name = "universal might+",
    description = "cosmic vessels passively strengthen creatures every 10 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "strong" then
        BasePassive.strong = BasePassive.strong + 0.1
      end
      Upgrades.PassiveStrongNodeT2.available = false
      Upgrades.PassiveStrongNodeT3.available = true
    end
  },

  PassiveStrongNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+um+",
    name = "+universal might+",
    description = "cosmic vessels passively strengthen creatures every 5 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "strong" then
        BasePassive.strong = BasePassive.strong + 0.2
      end
      Upgrades.PassiveStrongNodeT3.available = false
    end
  },

  PassiveScaryNode = {
    tier = 1,
    available = true,
    glyph = "da",
    name = "dark aura",
    description = "withered fruit passively spookify creatures every 20 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "scary" then
        BasePassive.scary = BasePassive.scary + 0.05
      end
      Upgrades.PassiveScaryNode.available = false
      Upgrades.PassiveScaryNodeT2.available = true
    end
  },

  PassiveScaryNodeT2 = {
    tier = 2,
    available = false,
    glyph = "da+",
    name = "dark aura+",
    description = "withered fruit passively spookify creatures every 10 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "scary" then
        BasePassive.scary = BasePassive.scary + 0.1
      end
      Upgrades.PassiveScaryNodeT2.available = false
      Upgrades.PassiveScaryNodeT3.available = true
    end
  },

  PassiveScaryNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+da+",
    name = "+dark aura+",
    description = "withered fruit passively spookify creatures every 5 seconds",
    types = {
      statNode = true
    },
    apply = function(node)
      if node.stat == "scary" then
        BasePassive.scary = BasePassive.scary + 0.2
      end
      Upgrades.PassiveScaryNodeT3.available = false
    end
  },

  ProductionUp = {
    tier = 1,
    available = true,
    glyph = "p+",
    name = "production speed up +",
    description = "food and loosh grow 25% faster",
    types = {
      resourceNode = true,
      statNode = true
    },
    apply = function(node)
      node.stats.production = node.stats.production * 1.5
      Upgrades.ProductionUp.available = false
    end
  },

  ProductionUpT2 = {
    tier = 2,
    available = true,
    glyph = "p++",
    name = "production speed up ++",
    description = "food and loosh grow 25% faster",
    types = {
      resourceNode = true,
      statNode = true
    },
    apply = function(node)
      node.stats.production = node.stats.production * 1.5
      Upgrades.ProductionUpT2.available = false
    end
  },

  ProductionUpT3 = {
    tier = 3,
    available = true,
    glyph = "+p+",
    name = "production speed up +++",
    description = "food and loosh grow 25% faster",
    types = {
      resourceNode = true,
      statNode = true
    },
    apply = function(node)
      node.stats.production = node.stats.production * 1.5
      Upgrades.ProductionUpT3.available = false
    end
  },

  LooshNodeT1 = {
    tier = 1,
    available = true,
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
      Upgrades.LooshNodeT2.available = true
    end
  },

  LooshNodeT2 = {
    tier = 2,
    available = false,
    glyph = "l++",
    name = "loosh node lv 3",
    description = "greatly increase loosh node production amount and required harvest time",
    types = {
      resourceNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.LooshNodeT2.available = false
      Upgrades.LooshNodeT3.available = true
    end
  },

  LooshNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+l+",
    name = "loosh node lv 4",
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


  ScaryNodeT1 = {
    tier = 1,
    available = true,
    glyph = "s+",
    name = "withered tree lv 2",
    description = "greatly increase withered fruit growth amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.ScaryNodeT1.available = false
      Upgrades.ScaryNodeT2.available = true
    end
  },

  ScaryNodeT2 = {
    tier = 2,
    available = false,
    glyph = "s++",
    name = "spooky node lv 3",
    description = "greatly increase withered fruit growth amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.ScaryNodeT2.available = false
      Upgrades.ScaryNodeT3.available = true
    end
  },

  ScaryNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+s+",
    name = "spooky node lv 4",
    description = "greatly increase withered fruit growth amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 3
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.ScaryNodeT3.available = false
    end
  },


  SmartNodeT1 = {
    tier = 1,
    available = true,
    glyph = "fb+",
    name = "fungal brain lv 2",
    description = "greatly increase fungal brain production amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.SmartNodeT1.available = false
      Upgrades.SmartNodeT2.available = true
    end
  },

  SmartNodeT2 = {
    tier = 2,
    available = false,
    glyph = "fb++",
    name = "fungal brain lv 3",
    description = "greatly increase fungal brain production amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.SmartNodeT2.available = false
      Upgrades.SmartNodeT3.available = true
    end
  },

  SmartNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+fb+",
    name = "fungal brain lv 4",
    description = "greatly increase fungal brain production amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 3
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.SmartNodeT3.available = false
    end
  },


  PowerNodeT1 = {
    tier = 1,
    available = true,
    glyph = "cv+",
    name = "cosmic vessel lv 2",
    description = "greatly increase cosmic vessel production amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.PowerNodeT1.available = false
      Upgrades.PowerNodeT2.available = true
    end
  },

  PowerNodeT2 = {
    tier = 2,
    available = false,
    glyph = "cv++",
    name = "cosmic vessel lv 3",
    description = "greatly increase cosmic vessel production amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 2
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.PowerNodeT2.available = false
      Upgrades.PowerNodeT3.available = true
    end
  },

  PowerNodeT3 = {
    tier = 3,
    available = false,
    glyph = "+cv+",
    name = "cosmic vessel lv 4",
    description = "greatly increase cosmic vessel production amount and required harvest time",
    types = {
      statNode = true
    },
    apply = function(node)
      node.stats.nodeTier = 3
      node.baseTimeToHarvest = node.baseTimeToHarvest * 4
      node.growthTime = node.growthTime + 5
      Upgrades.PowerNodeT3.available = false
    end
  },

  -- Wacky idea

  SpawnLooshNode = {
    tier = 2,
    available = true,
    glyph = "le",
    name = "loosh eruption",
    description = "spawn a new loosh vent",
    types = {
      creature = true
    },
    apply = function(creature)
      DebugCreature.nodeSpawn = true
      DebugCreature.nodeSpawnType = "ResourceNode"
      Upgrades.SpawnLooshNode.available = false
    end
  },

  SpawnStatNode = {
    tier = 1,
    available = true,
    glyph = "ln",
    name = "new food source",
    description = "spawn a random new source of tasty food",
    types = {
      creature = true
    },
    apply = function(creature)
      DebugCreature.nodeSpawn = true
      DebugCreature.nodeSpawnType = "statNode"
      Upgrades.SpawnStatNode.available = false
    end
  },

  SpawnPowerNode = {
    tier = 2,
    available = true,
    glyph = "ca",
    name = "cosmic anomoly",
    description = "spawn a new cosmic anomoly",
    types = {
      creature = true
    },
    apply = function(creature)
      DebugCreature.nodeSpawn = true
      DebugCreature.nodeSpawnType = "power"
      Upgrades.SpawnPowerNode.available = false
    end
  },

  SpawnScaryNode = {
    tier = 2,
    available = true,
    glyph = "ws",
    name = "withered sprout",
    description = "spawn a new withered sprout",
    types = {
      creature = true
    },
    apply = function(creature)
      DebugCreature.nodeSpawn = true
      DebugCreature.nodeSpawnType = "scary"
      Upgrades.SpawnScaryNode.available = false
    end
  },

  SpawnSmartNode = {
    tier = 2,
    available = true,
    glyph = "sm",
    name = "spore migration",
    description = "spawn a new fungal brain",
    types = {
      creature = true
    },
    apply = function(creature)
      DebugCreature.nodeSpawn = true
      DebugCreature.nodeSpawnType = "smart"
      Upgrades.SpawnSmartNode.available = false
    end
  },

  TimeManipulationT1 = {
    tier = 1,
    available = true,
    glyph = "tm1",
    name = "time manipulation T1",
    description = "gain 5 seconds for every tier one node",
    types = {
      statNode = true,
      resourceNode = true
    },
    apply = function(node)
      if node.stats.nodeTier == 1 then
        DoomClock = DoomClock + 5
      end
      Upgrades.TimeManipulationT1.available = false
    end
  },

  TimeManipulationT2 = {
    tier = 2,
    available = true,
    glyph = "tm2",
    name = "time manipulation T2",
    description = "gain 5 seconds for every tier two node",
    types = {
      statNode = true,
      resourceNode = true
    },
    apply = function(node)
      if node.stats.nodeTier == 2 then
        DoomClock = DoomClock + 5
      end
      Upgrades.TimeManipulationT2.available = false
    end
  },

  TimeManipulationT3 = {
    tier = 3,
    available = true,
    glyph = "tm3",
    name = "time manipulation T3",
    description = "gain 5 seconds for every tier three node",
    types = {
      statNode = true,
      resourceNode = true
    },
    apply = function(node)
      if node.stats.nodeTier == 3 then
        DoomClock = DoomClock + 5
      end
      Upgrades.TimeManipulationT3.available = false
    end
  },

  TimeManipulationT4 = {
    tier = 3,
    available = true,
    glyph = "tm4",
    name = "time manipulation T4",
    description = "gain 10 seconds for every tier four node",
    types = {
      statNode = true,
      resourceNode = true
    },
    apply = function(node)
      if node.stats.nodeTier == 4 then
        DoomClock = DoomClock + 5
      end
      Upgrades.TimeManipulationT4.available = false
    end
  },

  -- Growth



  AllGrowthUp = {
    tier = 3,
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

  -- FocusUpGrowth = {
  --   tier = "Growth",
  --   available = false,
  --   glyph = "-hf-",
  --   name = "hyperfocus",
  --   description = "creatures idle for far less time",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --     creature.stats.focus = creature.stats.focus + 9
  --     Upgrades.FocusUpGrowth.available = false
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

  SoldOutUpgrade = {
    tier = 1,
    available = false,
    glyph = ":c",
    name = "sold out",
    description = "sorry come back later, no refunds",
    types = {
      creature = true
    },
    apply = function(creature)
    end
  },

  -- SoldOutUpgradeT2 = {
  --   tier = 2,
  --   available = false,
  --   glyph = ":c",
  --   name = "sold out",
  --   description = "sorry come back later, no refunds",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --   end
  -- },

  -- SoldOutUpgradeT3 = {
  --   tier = 3,
  --   available = false,
  --   glyph = ":c",
  --   name = "sold out",
  --   description = "sorry come back later, no refunds",
  --   types = {
  --     creature = true
  --   },
  --   apply = function(creature)
  --   end
  -- },

  -- Non-player facing upgrades for growth stat harvesting
  HarvestGrowthStat = {
    tier = 68,
    smart = {
      types = {
        creature = true
      },
      apply = function(creature, node)
        creature.stats.smart = creature.stats.smart +
            (node.stats.nodeTier ^ 2) * node.stats.production * node.greedMultiplier * creature.stats.smartGrowthMulti *
            creature.stats.overallGrowthMulti
        CheckGrowthThresholds(creature)
      end
    },
    scary = {
      types = {
        creature = true
      },
      apply = function(creature, node)
        creature.stats.scary = creature.stats.scary +
            (node.stats.nodeTier ^ 2) * node.stats.production * node.greedMultiplier * creature.stats.scaryGrowthMulti *
            creature.stats.overallGrowthMulti
        CheckGrowthThresholds(creature)
      end
    },
    power = {
      types = {
        creature = true
      },
      apply = function(creature, node)
        creature.stats.power = creature.stats.power +
            (node.stats.nodeTier ^ 2) * node.stats.production * node.greedMultiplier * creature.stats.powerGrowthMulti *
            creature.stats.overallGrowthMulti
        CheckGrowthThresholds(creature)
      end
    },
  }
}

return upgrades


-- EvilGarbageCode = {
--   GrowthThresholds.smart[1]*0.25, GrowthThresholds.smart[1]*0.5,GrowthThresholds.smart[1]*0.75, GrowthThresholds.smart[1],
--   GrowthThresholds.smart[2]*0.25, GrowthThresholds.smart[2]*0.5,GrowthThresholds.smart[2]*0.75, GrowthThresholds.smart[2],
--   GrowthThresholds.smart[3]*0.25, GrowthThresholds.smart[3]*0.5,GrowthThresholds.smart[3]*0.75, GrowthThresholds.smart[3],
--   GrowthThresholds.smart[3]*0.25, GrowthThresholds.smart[3]*0.5,GrowthThresholds.smart[3]*0.75, GrowthThresholds.smart[3]*2
-- }
