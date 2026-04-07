local loader = (shared and shared.pload) or (getgenv and getgenv().pload)
if loader then
    return loader('modules/99567941238278.lua', true, true)
end
return loadstring(game:HttpGet('https://raw.githubusercontent.com/1AreYouMental110/pealzware/main/modules/99567941238278.lua', true))()
