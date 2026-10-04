# Traffic Radio Fix

A TweakXL and redscript mod for Cyberpunk 2077 2.31 that stops passing traffic cars playing their radio as
if it were inside the player's car.

## The fault

Every vehicle record names two sound sets: `player_audio_resource`, used when the player drives it, and
`traffic_audio_resource`, used when it drives as traffic. Each set picks a radio receiver sound. The player
receivers (`radio_car_*_player`) play as if inside the player's car and do not attenuate with distance; the
traffic receivers (`radio_car_*_npc`) are positioned in the world.

Eight base game records point `traffic_audio_resource` at a player set: six Mizutani Shion records
(`v_car_mizutani_shion`) and two Thorton Mackinaw BMF records (`v_car_thorton_larimore_traffic`, whose own
receiver is `radio_car_truck_player`). The Shion Sport and TDR spawn in traffic, so a passing one with its
radio on is heard at full volume as if it were the player's radio, and cuts off dead when its station stops.

## The fix

- `r6/tweaks/TrafficRadioFix/TrafficRadioFix.yaml` sets the eight records to the model's traffic set.
- `r6/scripts/TrafficRadioFix/TrafficRadioFix.reds` is a TweakXL `ScriptableTweak`. TweakXL runs it after
  every mod's tweaks have loaded; it moves any `Vehicle` record whose `traffic_audio_resource` names one of
  the 90 sound sets with a player receiver to that model's traffic set. The table is generated from the
  game's `cooked_metadata.audio_metadata`. With RedLogger installed it logs every swap to
  `r6\logs\mods\TrafficRadioFix__*.log`.

## Install

Download from Nexus Mods (link on release). Requires [TweakXL](https://www.nexusmods.com/cyberpunk2077/mods/4197)
and [redscript](https://www.nexusmods.com/cyberpunk2077/mods/1511); [RedLogger](https://www.nexusmods.com/cyberpunk2077/mods/31920)
is optional.

## License

Licensed under the [MIT License](LICENSE). Use, change and share this mod and its source, including in your own mods. Keep the licence notice with any copy.

## Disclaimer

This mod was developed with the assistance of an LLM. All in-game testing and code validation was performed by a human. No rogue AIs were permitted through the Blackwall.
