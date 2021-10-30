Package.Require("Prop/Possession.lua")

local function onTick()
	GetAimPropHighlighted()
end

Input.Bind("interact", function()
	local prop = GetAimPropHighlighted()
	if not prop or not prop:IsValid() then return end
	Events.CallRemote("PossessProp", prop, prop:GetBounds())
end)

function InitialiseProp()
	-- Subscribe to events
	Client.Subscribe("Tick", onTick)

	-- Uninitialisation
	Events.Subscribe("GameEnd", function()
		-- Unsubscribe from events
		Client.Unsubscribe("Tick", onTick)
	end)
end
