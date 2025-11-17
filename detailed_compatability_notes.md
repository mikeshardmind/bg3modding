
This file exists to document what is changed and how at a high level
usable by those curating mod collections to figure out if changes may conflict,
and possible load orders.

# BaseParameters

The entire thing is just setting some base game data keys:

precedence here will be load order determined if you're using other mods that touch these.

```
key "EncumberedMultiplier","75"
key "HeavilyEncumberedMultiplier","75"
key "CarryLimitMultiplier","75"
key "MaxPickUpMultiplier","50"
key "PickupObjectMultiplier","50"
key "TraderDroppedItemsPercentage","100"
key "TraderDroppedItemsCap","250"
```

# JustJump

It's just a Self-inheritence of Projectile_Jump overwriting the cost.

```
new entry "Projectile_Jump"
type "SpellData"
data "SpellType" "Projectile"
using "Projectile_Jump"
data "UseCosts" "Movement:Distance"
```

# StartingEquip

Implemented using osiris

Triggers on non-CC levelload
Triggers on companion joining the party

Grants base game items. The list of items may change in future versions,
all equipment is intended to be non-magical basic adventuring weaponry.

# UAFightingStyles

Fighting styles are implemented without reliance on other mods and
without modification of the base game.

Fighting styles are added to lists via compatability framework
(I'm lazy and already expect any serious modding to involve that)

Mod won't crash without SE+compat framework, but they fighting styles won't be available.

# WitchKnightTweaks

Progression modification via Compatability framework.

Mod won't crash without SE+compat framework, but the progression won't be modified.


