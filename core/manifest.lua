local manifest = {}

local guiValueAliases = {
	[""] = "new",
	new = "new",
	modern = "new",
	old = "new",
	classic = "new",
	rise = "new",
	wurst = "new"
}

local guiFiles = {
	new = "modern.lua"
}

local moduleDefinitions = {
	{
		file = "bedwars-game-core.lua",
		aliases = {"6872274481.lua", "8444591321.lua", "8560631822.lua"}
	},
	{
		file = "bedwars-game-cheat-engine.lua",
		aliases = {"CE6872274481.lua"}
	},
	{
		file = "bedwars-game-pealzware.lua",
		aliases = {"PW6872274481.lua"}
	},
	{
		file = "bedwars-lobby-core.lua",
		aliases = {"6872265039.lua"}
	},
	{
		file = "bedwars-lobby-cheat-engine-stub.lua",
		aliases = {"CE6872265039.lua"}
	},
	{
		file = "bedwars-lobby-pealzware.lua",
		aliases = {"PW6872265039.lua"}
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
