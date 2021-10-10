function SpawnHunter(player, pos, rot)
	local char = Character(pos, rot, "nanos-world::SK_PostApocalyptic")

	char:SetCameraMode(1)

	player:SetTeam(1)
	player:SetVOIPChannel(1)
	player:SetVOIPSetting(VOIPSetting.Local)

	player:Possess(char)
end

function SpawnProp(player, pos, rot)
	local char = Character(pos, rot, "nanos-world::SK_Mannequin")

	char:SetCanCrouch(false)
	char:SetCanAim(false)
	char:SetCanSprint(false)
	char:SetCanGrabProps(false)
	char:SetCanPickupPickables(false)
	char:SetCanPunch(false)

	char:SetCameraMode(2)
	char:SetSpeedMultiplier(2)

	player:SetValue("prop", false)

	player:Possess(char)

	player:SetTeam(2)
	player:SetVOIPChannel(2)
	player:SetVOIPSetting(VOIPSetting.Local)
end
