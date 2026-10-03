# Changelog

## [0.1.0] - 2026-10-04

### Added
- `TrafficRadioFixTweak` (TweakXL `ScriptableTweak`): after every mod's tweaks load, moves any vehicle record whose `traffic_audio_resource` names a sound set with a player radio receiver to that model's traffic set. Table of 90 sets generated from the game's audio metadata.
- Optional RedLogger log (`r6\logs\mods\TrafficRadioFix__*.log`): every swap, a summary line, and the static patch's records as the script finds them.
- Static tweak for the eight vanilla records affected (six Mizutani Shion records, two Mackinaw BMF records).
