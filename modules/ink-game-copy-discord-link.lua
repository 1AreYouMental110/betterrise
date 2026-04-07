repeat task.wait() until game:IsLoaded()

local invite = "discord.gg/pealzware"
local clipboardFunctions = {
	setclipboard,
	toclipboard,
	writeclipboard
}

local copied = false
for _, copy in ipairs(clipboardFunctions) do
	if type(copy) == "function" then
		local success = pcall(copy, invite)
		if success then
			copied = true
			break
		end
	end
end

pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Pealzware Public Testing",
		Text = copied and ("Copied "..invite.." to your clipboard.") or ("Discord invite: "..invite),
		Duration = 8
	})
end)

if not copied then
	warn("[ink-game-copy-discord-link.lua] Clipboard API unavailable. Invite:", invite)
end

return copied
