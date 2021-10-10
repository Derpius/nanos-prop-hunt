function SpawnHunter(player, pos, rot)
	local char = Character(pos, rot, "nanos-world::SK_PostApocalyptic")

	char:SetCanGrabProps(false)
	char:SetCanPunch(false)

	char:SetCameraMode(1)
	char:SetTeam(Team.Hunter)
	char:SetImpactDamageTaken(0)
	char:SetFallDamageTaken(0)

	player:SetVOIPChannel(Team.Hunter)
	player:SetVOIPSetting(VOIPSetting.Local)

	player:Possess(char)
	return char
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
	char:SetTeam(Team.Prop)
	char:SetImpactDamageTaken(0)
	char:SetFallDamageTaken(0)

	player:SetValue("prop", false)

	player:SetVOIPChannel(Team.Prop)
	player:SetVOIPSetting(VOIPSetting.Local)

	player:Possess(char)
	return char
end
