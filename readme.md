# Yes, you can use this

Mod Permissions/Licensing:

To the extent not restricted by other existing rightsholders, all work here is
given freely for the use of others.

Currently, no assets are licensed seperately.
This may change if any art is added, and will be noted as it applies, but I will not add
any art that will require the mods not be allowed to be reshared relatively unrestricted.

If a statement of gift to the public is insufficient and
you require a license for any portion of work which is not creative assets covered above
and is also not content covered by
[Larian Studio's Fan content terms](https://baldursgate3.game/bg3-fan-content-terms/)
You may assume your choice of any of the following licenses:

- [0BSD](https://spdx.org/licenses/0BSD.html)
- [MIT](https://spdx.org/licenses/MIT.html)
- [WTFPL](https://spdx.org/licenses/WTFPL.html)


If you like any of what I'm doing here enough that you're wanting to donate,
please give to a charity[^1] instead.

The main branch will be used for development, specific releases will be tagged.
Tweaks here will be structured across mods in a way that you can easily pick and
choose which rebalancing choices of mine you agree with for your own use and use
only those.

This also contains configuration files for various other mods, and details on them.

# Balance context

All changes here are done with the intent of use within the context of a
more comprehensive set of overhauls that increase game difficulty.
These changes are not done to make the game easier again.

All playtesting will be done in an environment intended to be more difficult
than a non-single save honor mode run.

The goal is for all changes to make the game and character progression
specifically feel nicer without making any strategy become a new outlier,
in either direction, strong or weak.

Many changes may move existing strategies more toward the norm.

Strategies that are specifically exploits (ie. vendor scams) may be invalidated without
the same level of consideration.

It is okay if different strategies peak at different content levels.


# Details of mods below

## BaseParameters

carry weight and loot from traders.

## JustJump

Jump only consumes movement, no bonus action cost.
This is a symmetric effect; the same applies to enemies.

## StartingEquip

Players:
1x Rusty Shortsword
1x Rusty Dagger
1x Studded Shield
1x Light Crossbow


Players and companions:
3x Hospital Surgery Kits (Intended for use with injury mods)

## UAFightingStyles

Add some fighting styles from Unearthed Arcana


From [2015 Underdark Characters UA](https://media.wizards.com/2015/downloads/dnd/02_UA_Underdark_Characters.pdf)

Implemented fully:

- Close Quarters Shooter
- Tunnel fighter


From [2015 WaterBorneAdeventures UA](https://media.wizards.com/2015/downloads/dnd/UA_Waterborne_v3.pdf)

Implemented fully:

- Mariner


From [2019 Class Feature Variants UA](https://media.wizards.com/2019/dnd/downloads/UA-ClassFeatures.pdf)

(Some of this was later included in Tasha's Cauldron of Everything)


Implemented fully:

- Interception
- Thrown Weapon Fighting


Partially Implemented:

- Superior Technique: Always gives Riposte.
- Druidic Warrior: Always gives Guidance and Shillelagh
- Blessed Warrior: Always gives Guidance and Sacred Flame


Not Implemented

- Blind Fighting
- Unarmed Fighting

I have no current intention on incorporating these in the context of BG3's balance

## WitchKnightTweaks

This is just some balance changes to
[Lumaterian's Witch Knight subclass mod](https://www.nexusmods.com/baldursgate3/mods/7984)
that are made with limitations of the vanilla game's implementation of warlock spell slots,
and with the intent of better matching existing design principles in bg3.

Note: This previously had some minor attempts at compensation buffs such as giving
specific invocations. This didnt balance well, and I've removed them for now,
only restoring RAW Sanguine Offering Charges.

I intend to look into finding a good way to handle multiclass warlock spell progression
instead, but this is not a high priority. It's okay to just not take the multiclass and play
witch knight for the flavor, it has that in spades and can hold up to
difficulty increasing mods.

### Changes

- Sanguine Offering Charges are 1 per Witch knight level,
  matching [source material](https://www.gmbinder.com/share/-M0i_wbRAX8qAz1OIjbF).

### Rationale (see above, outdated, but kept for reference of the issues)

Because of the base game's implementation of warlock spell slots,
both Witch knight and Warlock are punished if you multiclass these two together.

I don't particularly want to over-buff in compensation of this, and (previously, see note above)
have only given some melee focused warlock invocations at specific levels.
I may make more tweaks later, but allowing choice of invocation was too finicky,
and also allowed what I would consider certain options that are
unacceptable to give while retaining full base fighter feature scaling.

This mod does not attempt to prevent you from multiclassing with warlock after having it,
but doing so will likely weaken the build again due to base game implementation unless you
have a very specific build idea in mind

If you want to multiclass warlock/fighter,
the base game's battle master or the
5e fighter sublass combined mod's implementation of Brute fighter
will provide strictly better numerical power.

This leaves the Witch Knight closer to existing as if it's tabletop counterpart
had been multiclassed with hexblade but a little weaker
(in theory, the changes still need playtesting)

### Compatability

Modifies progression via compatability framework.

# Planned mods

See Issues tab

# Configurations

## Expansion

Has a modified xp curve based on being level 2 for the helm fight, and level 3 at the beach.

This is a curve based on https://thinkdm.org/2021/10/30/xp-valley/ with some of the
xp needed to reach level 2 shifted to lv 3, and a slight oddity at lv 18 removed.

If you'd like to create your own curve with similar justifications, but different shifts, below's
a lazy bit of python with rationale

```py
# See article here for details on ThinkDM's shifting of level xp to curve with CR:xp reward ratio
# https://thinkdm.org/2021/10/30/xp-valley/
# This is in the format of a PHB xp table
think_dm_raw = [0, 300, 1100, 2500, 5000, 9000, 14500, 21500, 31000, 43000, 58000, 77000, 100000, 125000, 155000, 187500, 225000, 270000, 315000, 355000]
# get this in per lv increments
tdm_per_lv = [think_dm_raw[i] - think_dm_raw[i-1] for i in range(1, 20)]
# there's an oddity in the think dm table where lvs 17 -> 18 and 18 -> 19 each take more xp than 19 -> 20
# It's the only place this happens, and I don't think I want to mimmick that, so:
# (this makes lv 18 arrive 5000 total xp earlier, lv 19 and 20 arrive at same total xp)
tdm_per_lv.sort()

# lv 2 once Lae'zel joins, shift that xp over.
tdm_per_lv[:2] = [30, sum(tdm_per_lv[:2]) -30]
# [30, 1070, 1400, 2500, 4000, 5500, 7000, 9500, 12000, 15000, 19000, 23000, 25000, 30000, 32500, 37500, 40000, 45000, 45000]
# vs base game:
# [300, 600, 1800, 3800, 6500, 8000, 9000, 12000, 14000, 20000, 24000, 20000, 20000, 25000, 30000, 30000, 40000, 40000, 50000]
# format needed for expansion mod config:
exp_cfg_keys = {f"Level{i}": v for i, v in enumerate(tdm_per_lv, 1)}
```

[^1]: [If you're now looking at charitable organizations, MSF is one I personally give to](https://www.msf.org)