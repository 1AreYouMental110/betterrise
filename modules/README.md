# Module Layout

Canonical gameplay modules now use descriptive names. Numeric place-id references are resolved by `main.lua` and the `games/` wrappers, not by duplicate files inside `modules/`.

## Canonical modules

- `bedwars-game-core.lua`: main BedWars gameplay module
- `bedwars-game-pealzware.lua`: PEALZ-specific BedWars additions layered on top of the core module
- `bedwars-game-cheat-engine.lua`: reduced BedWars gameplay path for restricted Cheat Engine-style environments
- `bedwars-lobby-core.lua`: main BedWars lobby module
- `bedwars-lobby-pealzware.lua`: PEALZ-specific BedWars lobby additions
- `bedwars-lobby-cheat-engine-stub.lua`: minimal BedWars lobby stub used when the full lobby module cannot run
- `bridge-duel.lua`: Bridge Duel gameplay
- `frontlines.lua`: Frontlines gameplay
- `ink-game-entry.lua`: Ink Game entrypoint that hands off to the bootstrap loader
- `ink-game-bootstrap.lua`: Ink Game executor checks, public-testing gating, and runtime dispatch
- `ink-game-runtime.lua`: main Ink Game runtime module
- `ink-game-copy-discord-link.lua`: readable helper used by the Ink Game public-testing notification
- `jailbreak.lua`: Jailbreak gameplay
- `skywars.lua`: SkyWars gameplay
- `skywars-lobby.lua`: SkyWars lobby/session tracking
- `survival-game.lua`: The Survival Game gameplay
- `99-nights-lobby.lua`: 99 Nights in the Forest lobby module
- `99-nights-game.lua`: 99 Nights in the Forest in-game module
- `universal-core.lua`: shared cross-game base functionality
- `universal-pealzware.lua`: shared PEALZ-specific cross-game additions

## Place-id aliases

- `6872274481`, `8444591321`, `8560631822` -> `bedwars-game-core.lua`
- `6872265039` -> `bedwars-lobby-core.lua`
- `11630038968`, `12011959048`, `14191889582`, `14662411059` -> `bridge-duel.lua`
- `5938036553` -> `frontlines.lua`
- `99567941238278`, `125009265613167` -> `ink-game-entry.lua`
- `606849621` -> `jailbreak.lua`
- `8768229691`, `13246639586`, `8542275097`, `8592115909`, `8951451142` -> `skywars.lua`
- `8542259458` -> `skywars-lobby.lua`
- `11156779721` -> `survival-game.lua`
- `126509999114328`, `PW126509999114328` -> `99-nights-lobby.lua`
- `79546208627805`, `PW79546208627805` -> `99-nights-game.lua`

## Notes

- `bedwars-game-core.lua` and `universal-core.lua` are the base shared implementations.
- `*-pealzware.lua` files are PEALZ-specific feature layers that load after the corresponding base module.
- `*-cheat-engine*.lua` files are restricted fallback paths for executors that cannot run the full module set.
- `ink-game-copy-discord-link.lua` replaces the old obfuscated `something.lua` helper with readable clipboard code.
- Legacy GUI themes were removed. Any saved `old`, `classic`, `rise`, or `wurst` GUI setting is now normalized to the modern GUI.

## Quick Answers

- Why are there still multiple BedWars files?
  They are different roles, not duplicates: core gameplay, PEALZ feature layer, and Cheat Engine fallback.
- Why are there two universal files?
  `universal-core.lua` is the shared cross-game base layer. `universal-pealzware.lua` is the PEALZ-specific add-on layer loaded after it.
