-- Config
Client.SetHighlightColor(Color(0, 50, 0, 0.4), 0, HighlightMode.OnlyVisible) -- Prop highlight

Package.Require("Hunter.lua")
Package.Require("Prop.lua")

Events.Subscribe("GameStart", function()
	local team = Client.GetLocalPlayer():GetControlledCharacter():GetTeam()
	if team == Team.Hunter then
		InitialiseHunter()
	elseif team == Team.Prop then
		InitialiseProp()
	else
		error("Game starting with invalid team!")
	end
end)
