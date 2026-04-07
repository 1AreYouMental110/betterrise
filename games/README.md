# Game Wrappers

This folder now contains one human-readable wrapper per real game or wrapper role.

## Canonical wrappers

- `99-nights-game.lua`: loads the 99 Nights in the Forest in-game module
- `99-nights-lobby.lua`: loads the 99 Nights in the Forest lobby module
- `bedwars-game.lua`: loads the main BedWars gameplay module
- `bedwars-game-cheat-engine.lua`: loads the BedWars gameplay fallback for restricted executors
- `bedwars-game-pealzware.lua`: loads the PEALZ-specific BedWars gameplay layer
- `bedwars-lobby.lua`: loads the main BedWars lobby module
- `bedwars-lobby-cheat-engine.lua`: loads the BedWars lobby fallback for restricted executors
- `bedwars-lobby-pealzware.lua`: loads the PEALZ-specific BedWars lobby layer
- `bridge-duel.lua`: loads the Bridge Duel module
- `frontlines.lua`: loads the Frontlines module
- `ink-game.lua`: loads the Ink Game entry module
- `jailbreak.lua`: loads the Jailbreak module
- `skywars.lua`: loads the SkyWars module
- `skywars-lobby.lua`: loads the SkyWars lobby module
- `survival-game.lua`: loads The Survival Game module
- `universal.lua`: loads the shared universal base module
- `universal-pealzware.lua`: loads the PEALZ-specific universal layer

## Notes

- Numeric place-id wrappers were removed from `games/`. Place-id resolution now lives in `core/manifest.lua` and `main.lua`.
- Wrapper names here are user-facing entrypoints, so they are intentionally clearer than some internal module filenames.
