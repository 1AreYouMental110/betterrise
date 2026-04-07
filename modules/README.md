# Module Layout

Canonical gameplay modules now use descriptive names. Numeric place-id references are resolved by `main.lua` and the `games/` wrappers, not by duplicate files inside `modules/`.

## Canonical modules

- `bedwars.lua`: BedWars gameplay
- `bedwars-lobby.lua`: BedWars lobby
- `bedwars-ce.lua`: BedWars Cheat Engine variant
- `bedwars-pw.lua`: BedWars Pealzware add-on
- `bedwars-lobby-ce.lua`: BedWars lobby Cheat Engine variant
- `bedwars-lobby-pw.lua`: BedWars lobby Pealzware add-on
- `bridge-duel.lua`: Bridge Duel gameplay
- `frontlines.lua`: Frontlines gameplay
- `inkgame.lua`: Ink Game shared entrypoint
- `jailbreak.lua`: Jailbreak gameplay
- `skywars.lua`: SkyWars gameplay
- `skywars-lobby.lua`: SkyWars lobby/session tracking
- `survival-game.lua`: The Survival Game gameplay
- `99-nights-lobby.lua`: 99 Nights in the Forest lobby module
- `99-nights-game.lua`: 99 Nights in the Forest in-game module
- `universal.lua`: shared universal features
- `pw-universal.lua`: shared Pealzware universal features

## Place-id aliases

- `6872274481`, `8444591321`, `8560631822` -> `bedwars.lua`
- `6872265039` -> `bedwars-lobby.lua`
- `11630038968`, `12011959048`, `14191889582`, `14662411059` -> `bridge-duel.lua`
- `5938036553` -> `frontlines.lua`
- `99567941238278`, `125009265613167` -> `inkgame.lua`
- `606849621` -> `jailbreak.lua`
- `8768229691`, `13246639586`, `8542275097`, `8592115909`, `8951451142` -> `skywars.lua`
- `8542259458` -> `skywars-lobby.lua`
- `11156779721` -> `survival-game.lua`
- `126509999114328`, `PW126509999114328` -> `99-nights-lobby.lua`
- `79546208627805`, `PW79546208627805` -> `99-nights-game.lua`

## Notes

- `inkgame2.lua`, `newinkgame.lua`, and `something.lua` are still part of the Ink Game load chain. They are intentionally left in place.
