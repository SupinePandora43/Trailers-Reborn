function SYSTEM:HandleConnectedTrailers(truck, trailers)
	local left = truck:GetLeftSignalEnabled()
	local right = truck:GetRightSignalEnabled()
	for i = 1, #trailers do
		net.Start("simfphys_turnsignal")
		net.WriteEntity(trailers[i])
		if left and not right then
			net.WriteInt(2, 32)
		elseif right and not left then
			net.WriteInt(3, 32)
		elseif left and right then
			net.WriteInt(1, 32)
		elseif not left or not right then
			net.WriteInt(0, 32)
		end
		net.Broadcast()
	end
end
