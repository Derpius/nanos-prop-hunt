Package.Require("Prop/Possession.lua")

function InitialiseProp(player, spawnPos, spawnRot)
	if VERBOSE then Package.Log("Initialising prop " .. tostring(player)) end

	local character = SpawnProp(player, spawnPos, spawnRot)

	Events.Subscribe("GameEnd", function()
		-- Clean up character
		player:UnPossess()
		character:Destroy()

		-- Set to spectator
		player:SetVOIPChannel(Team.Spectator)
		player:SetVOIPSetting(VOIPSetting.Global)
	end)
end
