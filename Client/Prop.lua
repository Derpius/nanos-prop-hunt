Package.Require("Prop/Possession.lua")

local function onTick()
	GetAimPropHighlighted()
end

local function keyPress()
	if key == "E" then
		Events.CallRemote("PossessProp", GetAimPropHighlighted())
	end
end

function InitialiseProp()
	-- Subscribe to events
	Client.Subscribe("Tick", onTick)
	Client.Subscribe("KeyPress", keyPress)

	-- Uninitialisation
	Events.Subscribe("GameEnd", function()
		-- Unsubscribe from events
		Client.Unsubscribe("Tick", onTick)
		Client.Unsubscribe("KeyPress", keyPress)
	end)
end
