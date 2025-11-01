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


If you like any of what I'm rebalancing/tweaking enough that you're wanting to donate,
please give to either a charity[^1], or to the original authors whose work
I am adjusting further with more mods.

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


## WitchKnightTweaks

This is just some balance changes to
[Lumaterian's Witch Knight subclass mod](https://www.nexusmods.com/baldursgate3/mods/7984)
that are made with limitations of the vanilla game's implementation of warlock spell slots,
and with the intent of better matching existing design principles in bg3

### Changes

- Sanguine Offering Charges are 1 per Witch knight level,
  matching [source material](https://www.gmbinder.com/share/-M0i_wbRAX8qAz1OIjbF).
- Lv 3: Gain pact weapon bind/summon abilities

### Rationale

Because of the base game's implementation of warlock spell slots,
both Witch knight and Warlock are punished if you multiclass these two together.

I don't particularly want to over-buff in compensation of this, and have only given some
melee focused warlock invocations at specific levels. I may make more tweaks later, but allowing
choice of invocation was too finicky, and also allowed what I would consider certain options that are
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

Notes for Invocations Exanded Mod:
- Improved pact weapon will *not* function without actual warlock levels.


# Planned mods

## YetAnotherSpellRebalanceMod

TODO

## Shop scam preventions

TODO

## No more rushing to withers

Better default lv 1 choices for companions, TODO


# Configurations

## Expansion

Has a modified xp curve based on being level 2 for the helm fight, and level 3 at the beach.

This is a curve based on https://thinkdm.org/2021/10/30/xp-valley/ with some of the
xp needed to reach levels 2 and 3
shifted to being needed to reach levels 6 and 7

If you'd like to create your own curve with similar justifications, but different shifts, below's
a lazy bit of python with rationale

```py
# This is the base game per level values needed to advance, for comparison:
# base_progression = [300, 600, 1800, 3800, 6500, 8000, 9000, 12000, 14000, 20000, 24000, 20000, 20000, 25000, 30000, 30000, 40000, 40000, 50000]
# See article here for details on ThinkDM's shifting of level xp to curve with CR:xp reward ratio
# https://thinkdm.org/2021/10/30/xp-valley/
# This is in the format of a PHB xp table
think_dm_raw = [0, 300, 1100, 2500, 5000, 9000, 14500, 21500, 31000, 43000, 58000, 77000, 100000, 125000, 155000, 187500, 225000, 270000, 315000, 355000]
# get this in per lv increments
tdm_per_lv = [think_dm_raw[i] - think_dm_raw[i-1] for i in range(1, 20)]
# don't allow freeing Us to reach lv 2 before Lae'zel
OUR_XP_TO2 = 30
# somewhat arbitrary. high enough that it can't be be reached before helm, low enough that you get it even skipping any combat xp in it.
OUR_XP_TO3 = 150
difficulty_mod_curve = [OUR_XP_TO2, OUR_XP_TO3, *tdm_per_lv[2:]]
difficulty_mod_curve[5] += tdm_per_lv[0] - OUR_XP_TO2
difficulty_mod_curve[6] += tdm_per_lv[1] - OUR_XP_TO3
# [20, 150, 1400, 2500, 4000, 5780, 7650, 9500, 12000, 15000, 19000, 23000, 25000, 30000, 32500, 37500, 45000, 45000, 40000]

# there's an oddity in the think dm table where lvs 17 -> 18 and 18 -> 19 each take more xp than 19 -> 20
# It's the only place this happens, and I don't think I want to mimmick that, so:
# (this makes lv 18 arrive 5000 total xp earlier, lv 19 and 20 arrive at same total xp)
difficulty_mod_curve.sort()
# [20, 150, 1400, 2500, 4000, 5780, 7650, 9500, 12000, 15000, 19000, 23000, 25000, 30000, 32500, 37500, 40000, 45000, 45000]
# format needed for expansion mod config:
exp_cfg_keys = {f"Level{i}": v for i, v in enumerate(difficulty_mod_curve, 1)}
```

[^1]: [If you're now looking at charitable organizations, MSF is one I personally give to](https://www.msf.org)