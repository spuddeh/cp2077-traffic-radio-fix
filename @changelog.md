# Changelog - Traffic Radio Fix

## [1.0.1] - 2026-11-02

### Added
- The two player-radio sound sets new in game 2.5 in the table (the cars are from 2.3; on 2.31 they had no sound sets of
  their own): `v_car_chevalier_centurion_legatus` and
  `v_car_yaiba_semimaru` (92 sets, regenerated from the 2.5 audio metadata). Their vanilla records already use
  traffic sets; the pairs catch car mods built on them.

### Removed
- The static tweak `r6/tweaks/TrafficRadioFix/TrafficRadioFix.yaml` and the script's log of its records: the
  script alone fixes every record (measured on 2.5: `swapped 2`, the Mackinaw BMF pair).

### Notes
- Game 2.5 points the six Shion records at `v_car_mizutani_shion_traffic` itself; only the Mackinaw BMF pair is
  still wrong in vanilla 2.5.

## [1.0.0] - 2026-10-04

First Nexus release.

### Added
- `TrafficRadioFixTweak` (TweakXL `ScriptableTweak`): after every mod's tweaks load, moves any vehicle record whose `traffic_audio_resource` names a sound set with a player radio receiver to that model's traffic set. Table of 90 sets generated from the game's audio metadata.
- Optional RedLogger log (`r6\logs\mods\TrafficRadioFix__*.log`): every swap, a summary line, and the static patch's records as the script finds them.
- Static tweak for the eight vanilla records affected (six Mizutani Shion records, two Mackinaw BMF records).
