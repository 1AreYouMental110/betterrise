local loader = (shared and shared.pload) or (getgenv and getgenv().pload)
if loader then
    return loader('modules/bedwars-game-pealzware.lua', true, true)
end
return loadstring(game:HttpGet('https://raw.githubusercontent.com/1AreYouMental110/pealzware/main/modules/bedwars-game-pealzware.lua', true))()
