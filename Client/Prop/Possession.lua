local highlighted
Client.Subscribe("Tick", function()
	local eyePos = Render.Deproject(Render.GetViewportSize() / 2)

	local trace = Client.Trace(
		eyePos.Position,
		eyePos.Position + eyePos.Direction * 3000,
		CollisionChannel.PhysicsBody,
		false,
		true
	)

	if trace.Entity == highlighted then return end

	if trace.Success and trace.Entity and trace.Entity:IsValid() and trace.Entity:GetType() == "Prop" then
		trace.Entity:SetHighlightEnabled(true, 0)
		highlighted = trace.Entity
	elseif highlighted then
		highlighted:SetHighlightEnabled(false)
		highlighted = nil
	end
end)

Client.Subscribe("KeyPress", function(key)
	if highlighted and key == "E" then
		Events.CallRemote("PossessProp", highlighted)
	end
end)
