local weapons = {
	NanosWorldWeapons.AK47
}

local function blind(player)

end

local function unblind(player)

end

local function giveLoadout(character)
	character:PickUp(weapons[1]())
end

function InitialiseHunter(player, spawnPos, spawnRot)
	if VERBOSE then Package.Log("Initialising hunter " .. tostring(player)) end

	-- Spawn character
	local character = SpawnHunter(player, spawnPos, spawnRot)

	-- Disable movement
	character:SetSpeedMultiplier(0)

	-- Blind them
	blind(player)

	-- Set up damage events
	Prop.Subscribe("TakeDamage", function(prop, damage, bone, type, from_direction, instigator, causer)
		if instigator ~= player then return end
		character:ApplyDamage(HUNTER_DAMAGE_MUL * damage)
	end)

	-- Unblind on game start
	Events.Subscribe("GameStart", function()
		if VERBOSE then Package.Log("Freeing hunter " .. tostring(player)) end

		-- Give loadout and initialise weapon switching logic
		giveLoadout(character)

		-- Unblind
		unblind(player)

		-- Enable movement
		character:SetSpeedMultiplier(1)
	end)

	Events.Subscribe("GameEnd", function()
		-- Clean up character
		player:UnPossess()
		character:Destroy()

		-- Set to spectator
		player:SetVOIPChannel(Team.Spectator)
		player:SetVOIPSetting(VOIPSetting.Global)
	end)
end
