SYSTEM.NAME = "controls"

function SYSTEM.HandleTruck(ITruck)
	isITrailer(ITruck)
	if ITruck.connection and ITruck.connection.ent then
		ITruck.connection.ent:SetupControls(ITruck.ent:GetDriver())
	end
end
