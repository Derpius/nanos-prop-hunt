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
	-- Create UI

	-- Subscribe to events
	Client.Subscribe("Tick", onTick)
	Client.Subscribe("KeyPress", keyPress)
end

function UninitialiseProp()
	-- Delete UI

	-- Unsubscribe from events
	Client.Unsubscribe("Tick", onTick)
	Client.Unsubscribe("KeyPress", keyPress)
end
