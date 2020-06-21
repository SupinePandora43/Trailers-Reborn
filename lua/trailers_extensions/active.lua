SYSTEM.NAME = "active"

function SYSTEM.HandleTruck(ITruck)
	isITrailer(ITruck)
	if ITruck.connection and ITruck.connection.ent then
		ITruck.connection.ent:SetActive(ITruck.ent:EngineActive())
	end
end
