
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


# ZeroOverrideDialogueFixes

The entire thing is osiris DB/flag manipulation.

Without a mod significantly changing how those values are used,
it's unlikely to conflict with anything.

The nightsong point fix
(and there's an argument that it's not actually bugged in vanilla....)

Modifies these:

Global Counter: ORI_Shadowheart_NightsongPoints
Global Flag: ORI_Shadowheart_State_NightsongPoint_HasEnoughPoints_82893505-534a-461a-8dd5-0f4677dad6ce

temporarily and conditionally.

The thiefling fixes conditionally set:

Global Flag: DEN_Thieflings_Event_PlayerRobbed_ec548492-a88e-ae81-ca4d-7970d804ec5b

and also interact with the crime system to disable the crimes that are unique to the tiefling hideout,
because of some unfortunate implementations that result in being stopped for the same
crime until every party member has individually been adressed by the guards.

murder, theft, etc are still dealt with normally.
