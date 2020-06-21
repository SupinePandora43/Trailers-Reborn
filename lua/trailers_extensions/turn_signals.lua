SYSTEM.NAME = "turn_signals"

function SYSTEM.HandleTruck(ITruck)
	isITrailer(ITruck)
	if ITruck.connection and ITruck.connection.ent then
		local cENT = ITruck.connection.ent
		local direction = 1
		if ITruck.ent.TSMode then
			direction = ITruck.ent.TSMode
		end
		cENT.TSMode = direction
		net.Start("simfphys_turnsignal")
		net.WriteEntity(cENT)
		net.WriteInt(direction, 32)
		-- if left and not right then
		-- 	net.WriteInt(2, 32)
		-- elseif right and not left then
		-- 	net.WriteInt(3, 32)
		-- elseif left and right then
		-- 	net.WriteInt(1, 32)
		-- elseif not left or not right then
		-- 	net.WriteInt(0, 32)
		-- end
		-- net.WriteInt(cENT.TSMode, 32)
		net.Broadcast()
	end
end
