# pealzware

Primary entrypoint: `loader.lua`

Repo layout:
- `core/`: shared runtime helpers and resolver metadata
- `gui/`: actual GUI implementations
- `modules/`: universal and place-specific modules
- `extra/`: changelog, installer, and other auxiliary payloads
- `assets/`: bundled UI assets
- `profiles/`: bundled profile presets

Notes:
- `MainScript.lua`, `NewMainScript.lua`, and `loadstring` are kept as bootstrap shims.
- Saved GUI values such as `new` and `old` are still supported even though the real GUI files are now `modern.lua` and `classic.lua`.
- BedWars and lobby place IDs are resolved through `core/manifest.lua` so renamed module files still load cleanly.
