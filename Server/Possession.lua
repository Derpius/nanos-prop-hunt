function PossessProp(player, prop)
	Package.Log("Possessing prop...")
	local char = player:GetControlledCharacter()

	local old = player:GetValue("prop")
	if old and old:IsValid() then
		old:Detach()
		old:Destroy()
	else
		char:SetMesh("nanos-world::SK_None")
	end

	char:SetLocation(target:GetLocation())
	char:SetRotation(target:GetRotation())

	prop:SetGrabbable(false)
	prop:AttachTo(char, AttachmentRule.SnapToTarget)

	player:SetValue("prop", prop)

	char:SetCapsuleSize(32, 64)
	char:SetCollision(CollisionType.StaticOnly)

	player:Possess(char)
end