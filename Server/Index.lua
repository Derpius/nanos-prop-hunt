-- Configurables
VERBOSE = true -- Toggle verbose logging

ROUND_WAIT_TIME = 15 -- Seconds before starting a match after the minimum number of players have joined
ROUND_TIME = 0.5 -- Length of a round in minutes

HUNTER_PERCENT = 0.2 -- Percentage of players to be hunters
HUNTER_BLIND_TIME = 10 -- Seconds before unblinding hunters
HUNTER_DAMAGE_MUL = 0.6 -- Percentage of damage hunters deal to themselves when attacking a non player prop

math.randomseed(os.time())

Package.RequirePackage("nanos-world-weapons")

Package.Require("Spawning.lua")

Package.Require("Hunter.lua")
Package.Require("Prop.lua")

Package.Require("GameManager.lua")

TestEntity = Prop(Vector(50, 0, 0), Rotator(), "nanos-world::SM_Crate_07")

Player.Subscribe("Spawn", function(player)
	Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> has joined the server")

	GameManager.HandleJoin(player)
end)

Player.Subscribe("Destroy", function(player)
	GameManager.HandleLeave(player)

	local char = player:GetControlledCharacter()
	if char then char:Destroy() end

	Server.BroadcastChatMessage("<cyan>" .. player:GetName() .. "</> has left the server")
end)
