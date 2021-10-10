function PossessProp(player, prop)
	if not prop or not prop:IsValid() then
		error("Cannot possess invalid prop")
	end

	local char = player:GetControlledCharacter()

	local old = player:GetValue("prop")
	if old and old:IsValid() then
		old:Detach()
		old:Destroy()
	else
		char:SetMesh("nanos-world::SK_None")
	end

	char:SetLocation(prop:GetLocation())
	char:SetRotation(prop:GetRotation())

	prop:SetGrabbable(false)
	prop:AttachTo(char, AttachmentRule.SnapToTarget)

	player:SetValue("prop", prop)

	char:SetCapsuleSize(32, 64)
	char:SetCollision(CollisionType.StaticOnly)

	player:Possess(char)
end

Events.Subscribe("PossessProp", function(player, prop)
	if not player or not prop or not player:IsValid() or not prop:IsValid() or prop:GetType() ~= "Prop" then return end
	PossessProp(player, prop)
end)
