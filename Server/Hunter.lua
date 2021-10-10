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

	-- Unblind after n seconds on game start
	local timerHandle
	Events.Subscribe("GameStart", function()
		timerHandle = Timer.SetTimeout(function()
			if VERBOSE then Package.Log("Freeing hunter " .. tostring(player)) end

			-- Give loadout and initialise weapon switching logic
			giveLoadout(character)

			-- Unblind
			unblind(player)

			-- Enable movement
			character:SetSpeedMultiplier(1)
		end, HUNTER_BLIND_TIME * 1000)
	end)

	Events.Subscribe("GameEnd", function()
		-- Remove free timer if needed
		if timerHandle then
			Timer.ClearTimeout(timerHandle)
		end

		-- Clean up character
		player:UnPossess()
		character:Destroy()

		-- Set to spectator
		player:SetVOIPChannel(Team.Spectator)
		player:SetVOIPSetting(VOIPSetting.Global)
	end)
end
