local manifest = {}

local guiValueAliases = {
	[""] = "new",
	new = "new",
	modern = "new",
	old = "old",
	classic = "old",
	rise = "rise",
	wurst = "wurst"
}

local guiFiles = {
	new = "modern.lua",
	old = "classic.lua",
	rise = "rise.lua",
	wurst = "wurst.lua"
}

local moduleAliases = {
	["6872274481.lua"] = "bedwars.lua",
	["CE6872274481.lua"] = "bedwars-ce.lua",
	["PW6872274481.lua"] = "bedwars-pw.lua",
	["6872265039.lua"] = "bedwars-lobby.lua",
	["CE6872265039.lua"] = "bedwars-lobby-ce.lua",
	["PW6872265039.lua"] = "bedwars-lobby-pw.lua",
	["universal.lua"] = "universal.lua",
	["PWUniversal.lua"] = "pw-universal.lua"
}

function manifest.normalizeGuiValue(guiValue)
	local normalized = string.lower(tostring(guiValue or ""))
	return guiValueAliases[normalized] or guiValueAliases[""]
end

function manifest.resolveGuiFile(guiValue)
	local normalized = manifest.normalizeGuiValue(guiValue)
	return guiFiles[normalized] or guiFiles.new
end

function manifest.resolveModuleFile(fileName)
	local normalized = tostring(fileName or "")
	return moduleAliases[normalized] or normalized
end

return manifest
