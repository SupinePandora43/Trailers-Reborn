if not simfphys then
	error(
					"Install SimFphys first https://steamcommunity.com/workshop/filedetails/?id=771487490")
end

Trailers = {
	Init = function(vehtable)
		if CLIENT then return end
		if vehtable.github then return end
		table.insert(Trailers.cars, vehtable)
	end,
	Register = function(name, extension)
		if CLIENT then return end
		Trailers.extensions[name] = extension
	end,
	Connect = function(car, connection)
		PrintTable(Trailers.cars)
		local lastCar = car
		local last = false
		print("starting finding lastCar")
		for _i= 1,244 do -- i can't use while, i don't want comments about lua panic
			for _, value in pairs(Trailers.cars) do
				if lastCar == value.ent then
					if value.connection then
						lastCar = value.connection.ent
					else
						last=true
						break
					end
				end
			end
			if last then
				break
			end
		end
		if last then
			local lastCarInfo = nil
			for _, value in pairs(Trailers.cars) do
				if value.ent==lastCar then
					PrintTable(value)
					lastCarInfo=value
					break
				end
			end
			print(lastCar)
			if lastCarInfo.outputPos then
			local outputPosW = lastCar:LocalToWorld(lastCarInfo.outputPos)
			for _, value in pairs(Trailers.cars) do
				if IsValid(value.ent) and value.ent ~= lastCar
				 then
				local inputPos = value.ent:LocalToWorld(value.inputPos)
				print("check distance")
				print(last~=value.ent)
				print(outputPosW)
				print(inputPos)
				print(outputPosW:Distance(inputPos))
				if true then
				-- if last~=value.ent and outputPosW:Distance(inputPos)<=50 then
					print("BALL")
					constraint.AdvBallsocket(lastCar, value.ent, 0, 0, lastCarInfo.outputPos, value.inputPos,0,0,0,360,0,360,0,360,0,0,0,0)
					-- break
				end else
					PrintTable(value) end
			end else print("can't find output pos") end
			-- constraint.AdvBallsocket( lastCar, , number Bone1, number Bone2, Vector LPos1, Vector LPos2, number forcelimit, number torquelimit, number xmin, number ymin, number zmin, number xmax, number ymax, number zmax, number xfric, number yfric, number zfric, number onlyrotation, number nocollide )
		else
			error("can't find last")
		end
	end,
	Disconnect = function(car, connection) end,
	cars = {},
	github = {},
	extensions = {}
}

util.AddNetworkString("trailers_reborn_ply_vehicle")
util.AddNetworkString("trailers_reborn_connect")
util.AddNetworkString("trailers_reborn_disconnect")
hook.Add("PlayerEnteredVehicle", "trailers_reborn_player_listener",
         function(ply, veh)
	if veh:IsValid() and simfphys.IsCar(veh:GetParent()) then
		for _, trucki in pairs(Trailers.cars) do
			if trucki.ent:IsVehicle() then
			if trucki.ent:GetDriverSeat() == veh then
				if veh:GetDriver() == ply then
					net.Start("trailers_reborn_ply_vehicle")
					net.WriteBool(true)
					net.Send(ply)
				end
			end end
		end
	end
end)
hook.Add("PlayerLeaveVehicle", "trailers_reborn_player_listener",
         function(ply, veh)
	net.Start("trailers_reborn_ply_vehicle")
	net.WriteBool(false)
	net.Send(ply)
end)
hook.Add("Tick", "trailers_reborn_tick", function() end)
net.Receive("trailers_reborn_connect", function(len, ply)
	local seat = ply:GetVehicle()
	if IsValid(seat) and IsValid(seat:GetParent()) and
					simfphys.IsCar(seat:GetParent()) then
		for _, trucki in pairs(Trailers.cars) do
			if trucki.ent:IsVehicle() then
			if trucki.ent == seat:GetParent() then
				if seat:GetParent():GetDriver() == ply then
					Trailers.Connect(trucki.ent,net.ReadUInt(8))
				end
			end end
		end
	else
		ErrorNoHalt("You're not in vehicle " .. ply)
	end
end)
net.Receive("trailers_reborn_disconnect", function(len, ply)
	local seat = ply:GetVehicle()
	if IsValid(seat) and IsValid(seat:GetParent()) and
					simfphys.IsCar(seat:GetParent()) then
		for _, trucki in pairs(Trailers.trucks) do
			if trucki.ent == seat:GetParent() then
				if seat:GetParent():GetDriver() == ply then
					print(net.ReadUInt(8)) -- 254 trailers max
				end
			end
		end
	else
		ErrorNoHalt("You're not in vehicle " .. ply)
	end
end)
