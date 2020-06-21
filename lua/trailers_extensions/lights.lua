SYSTEM.NAME = "lights"

function SYSTEM.HandleTruck(ITruck)
	isITrailer(ITruck)
	local car = ITruck.ent
	if ITruck.connection and ITruck.connection.ent then
		local cENT = ITruck.connection.ent
		cENT:SetLightsEnabled(car:GetLightsEnabled())
		cENT:SetFogLightsEnabled(car:GetFogLightsEnabled())
		cENT:SetEMSEnabled(car:GetEMSEnabled())
	end
end
