# Module Layout

This repo is now BedWars-only.

## Canonical modules

- `bedwars-game-core.lua`: main BedWars gameplay module
- `bedwars-game-pealzware.lua`: PEALZ-specific BedWars gameplay additions layered on top of the core module
- `bedwars-game-cheat-engine.lua`: reduced BedWars gameplay path for restricted Cheat Engine-style environments
- `bedwars-lobby-core.lua`: main BedWars lobby module
- `bedwars-lobby-pealzware.lua`: PEALZ-specific BedWars lobby additions
- `bedwars-lobby-cheat-engine-stub.lua`: minimal BedWars lobby stub used when the full lobby module cannot run
- `bedwars-shared-core.lua`: shared BedWars support code loaded before the place-specific module
- `bedwars-shared-pealzware.lua`: PEALZ-specific shared BedWars layer loaded after the shared core

## Place-id aliases

- `6872274481`, `8444591321`, `8560631822` -> `bedwars-game-core.lua`
- `6872265039` -> `bedwars-lobby-core.lua`

## Notes

- `*-pealzware.lua` files are PEALZ-specific feature layers that load after the corresponding base module.
- `*-cheat-engine*.lua` files are restricted fallback paths for executors that cannot run the full module set.
- Legacy GUI themes were removed. Any saved `old`, `classic`, `rise`, or `wurst` GUI setting is now normalized to the modern GUI.
