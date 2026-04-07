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

local moduleDefinitions = {
	{
		file = "bedwars.lua",
		aliases = {"6872274481.lua", "8444591321.lua", "8560631822.lua"}
	},
	{
		file = "bedwars-ce.lua",
		aliases = {"CE6872274481.lua"}
	},
	{
		file = "bedwars-pw.lua",
		aliases = {"PW6872274481.lua"}
	},
	{
		file = "bedwars-lobby.lua",
		aliases = {"6872265039.lua"}
	},
	{
		file = "bedwars-lobby-ce.lua",
		aliases = {"CE6872265039.lua"}
	},
	{
		file = "bedwars-lobby-pw.lua",
		aliases = {"PW6872265039.lua"}
	},
	{
		file = "bridge-duel.lua",
		aliases = {"11630038968.lua", "12011959048.lua", "14191889582.lua", "14662411059.lua"}
	},
	{
		file = "frontlines.lua",
		aliases = {"5938036553.lua"}
	},
	{
		file = "inkgame.lua",
		aliases = {"99567941238278.lua", "125009265613167.lua"}
	},
	{
		file = "jailbreak.lua",
		aliases = {"606849621.lua"}
	},
	{
		file = "skywars.lua",
		aliases = {"8768229691.lua", "13246639586.lua", "8542275097.lua", "8592115909.lua", "8951451142.lua"}
	},
	{
		file = "skywars-lobby.lua",
		aliases = {"8542259458.lua"}
	},
	{
		file = "survival-game.lua",
		aliases = {"11156779721.lua"}
	},
	{
		file = "99-nights-lobby.lua",
		aliases = {"126509999114328.lua", "PW126509999114328.lua"}
	},
	{
		file = "99-nights-game.lua",
		aliases = {"79546208627805.lua", "PW79546208627805.lua"}
	},
	{
		file = "universal.lua",
		aliases = {"universal.lua"}
	},
	{
		file = "pw-universal.lua",
		aliases = {"PWUniversal.lua", "pw-universal.lua"}
	}
}

local moduleAliases = {}
local canonicalModuleFiles = {}

for _, definition in ipairs(moduleDefinitions) do
	canonicalModuleFiles[definition.file] = true
	for _, alias in ipairs(definition.aliases) do
		moduleAliases[alias] = definition.file
	end
end

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

function manifest.resolveOptionalModuleFile(fileName)
	local resolved = manifest.resolveModuleFile(fileName)
	return canonicalModuleFiles[resolved] and resolved or nil
end

function manifest.getModuleDefinitions()
	return moduleDefinitions
end

return manifest
