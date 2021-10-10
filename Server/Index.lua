Package.Require("Spawning.lua")
Package.Require("Prop/Possession.lua")

TestEntity = Prop(Vector(50, 0, 0), Rotator(), "nanos-world::SM_Crate_07")

Player.Subscribe("Spawn", function(player)
	Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> has joined the server")

	SpawnProp(player, Vector(), Rotator())
	--PossessProp(player, TestEntity)
end)

Player.Subscribe("Destroy", function(player)
	local char = player:GetControlledCharacter()
	if char then char:Destroy() end

	Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> has left the server")
end)
