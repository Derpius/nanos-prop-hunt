-- Configurables
VERBOSE = true -- Toggle verbose logging

HUNTER_BLIND_TIME = 10 -- Seconds before unblinding hunters
HUNTER_DAMAGE_MUL = 0.6 -- Percentage of damage hunters deal to themselves when attacking a non player prop

Package.RequirePackage("nanos-world-weapons")

Package.Require("Spawning.lua")

Package.Require("Hunter.lua")
Package.Require("Prop.lua")

TestEntity = Prop(Vector(50, 0, 0), Rotator(), "nanos-world::SM_Crate_07")

Player.Subscribe("Spawn", function(player)
	Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> has joined the server")

	InitialiseHunter(player, Vector(), Rotator())
	Events.Call("GameStart")
end)

Player.Subscribe("Destroy", function(player)
	local char = player:GetControlledCharacter()
	if char then char:Destroy() end

	Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> has left the server")
end)
