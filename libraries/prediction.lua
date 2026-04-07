local loader = (shared and shared.pload) or (getgenv and getgenv().pload)
if loader then
    return loader('core/prediction.lua', true, true)
end
return loadstring(game:HttpGet('https://raw.githubusercontent.com/1AreYouMental110/pealzware/main/core/prediction.lua', true))()
