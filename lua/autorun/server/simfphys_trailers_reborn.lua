if not simfphys then
	error(
					"Install SimFphys first https://steamcommunity.com/workshop/filedetails/?id=771487490")
end
function isITrailer(ITrailer)
	if not istable(ITrailer) then error("IT DOESN'T ITRAILER") end
	return true
end
local function findPreLast(ICar, IOriginal, safe) -- shit code
	PrintTable(ICar)
	isITrailer(ICar)
	if IOriginal then isITrailer(IOriginal) end
	safe = safe or 0
	if safe > 255 then error("LUA PANIC") end
	if isentity(ICar) then ICar = Trailers._getCarInfo(car) end
	for _, IEnt in pairs(Trailers.cars) do
		if ICar.ent ~= IEnt.ent and ICar.connection then
			if ICar.connection.ent == IEnt.ent then
				print("recursive")
				return findPreLast(IEnt, IOriginal, safe)
			end
		end
	end
	if IOriginal then PrintTable(IOriginal) end
	if IOriginal and IsValid(IOriginal.ent) then return IOriginal end
	return ICar
end
local function findLast(ICar, safe) -- good recursion
	isITrailer(ICar)
	safe = safe or 0
	if safe > 255 then error("LUA PANIC") end
	for _, IEnt in pairs(Trailers.cars) do
		if ICar.ent ~= IEnt.ent then
			if ICar.connection.ent == IEnt.ent then return findLast(IEnt, safe) end
		end
	end
	return ICar
end
local function initTimer()
	timer.Create("trailers", 1, 0, function()
		for i = 1, #Trailers.cars do
			if IsValid(Trailers.cars[i].ent) then
				for i_extension = 1, #Trailers.extensions do
					if Trailers.extensions[i_extension].HandleTruck then
						Trailers.extensions[i_extension].HandleTruck(Trailers.cars[i])
					end
				end
			else
				table.remove(Trailers.cars, i)
			end
		end
	end)
end
Trailers = {
	Init = function(vehtable)
		if not timer.Exists("trailers") then initTimer() end
		if CLIENT then return end
		if vehtable.github then return end
		vehtable.connection = {}
		local oldOnDelete = vehtable.ent.OnDelete
		vehtable.ent.OnDelete = function(ent)
			timer.Remove("trailers_" .. ent:EntIndex())
			for k, v in pairs(Trailers.cars) do
				if ent == v.ent then table.remove(Trailers.cars, k) end
			end
			oldOnDelete(ent)
		end
		table.insert(Trailers.cars, vehtable)
		net.Start("trailers_reborn_debug_spheres")
		net.WriteEntity(vehtable.ent)
		if vehtable.inputPos then
			net.WriteBool(true)
			net.WriteVector(vehtable.inputPos)
		else
			net.WriteBool(false)
		end
		if vehtable.outputPos then
			net.WriteBool(true)
			net.WriteVector(vehtable.outputPos)
		else
			net.WriteBool(false)
		end
		net.Broadcast()
	end,
	Register = function(codename, extension)
		if CLIENT then return end
		Trailers.extensions[codename] = extension
	end,
	_getCarInfo = function(car)
		for i = 1, #Trailers.cars do
			if Trailers.cars[i].ent == car then return Trailers.cars[i] end
		end
	end,
	_isConnectable = function(IEnt1, IEnt2)
		isITrailer(IEnt1)
		isITrailer(IEnt2)
		MsgC(Color(100, 0, 0), IEnt1, Color(100, 100, 0), IEnt2)
		PrintTable(IEnt1)
		PrintTable(IEnt2)
		if (IEnt1.outputPos and IEnt2.inputPos) then
			if IEnt1.ent:LocalToWorld(IEnt1.outputPos):DistToSqr(
							IEnt2.ent:LocalToWorld(IEnt2.inputPos)) < 100 * 100 then return true end
		end
		return false
	end,
	_getIConnectable = function(IEnt)
		for i = 1, #Trailers.cars do
			if IEnt ~= Trailers.cars[i] and
							Trailers._isConnectable(IEnt, Trailers.cars[i]) then
				return Trailers.cars[i]
			end
		end
		return false
	end,
	Connect = function(car)
		print("car is ", car)
		local ICar = Trailers._getCarInfo(car)
		isITrailer(ICar)
		local ITrail = findLast(ICar)
		isITrailer(ITrail)
		local IConnectable = Trailers._getIConnectable(ITrail)
		if IConnectable then
			isITrailer(IConnectable)
			if ITrail.outputPos and IConnectable then
				local constraintEntity = constraint.AdvBallsocket( --
				ITrail.ent, IConnectable.ent, -- entities
				0, 0, -- bones
				ITrail.outputPos, IConnectable.inputPos, -- connection positions in local-space
				0, 0, -- force limit, torque limit
				0, 0, 0, -- xmin, ymin, zmin
				360, 360, 360, -- xmax, ymax, zmax
				0, 0, 0, -- xfric, yfric, zfric
				0, 0 -- only rotation, nocollide
				)
				if constraintEntity then
					ITrail.connection.ent = IConnectable.ent
					ITrail.connection.constraint = constraintEntity
				end
			end
		else
			MsgC(Color(255, 0, 0), "cannot find connectable car")
		end
	end,
	Disconnect = function(car)
		print(car)
		local ICar = Trailers._getCarInfo(car)
		local ITrail = findPreLast(ICar)
		isITrailer(ITrail)
		PrintTable(ITrail)
		if ITrail.connection.constraint then
			ITrail.connection.ent = nil
			SafeRemoveEntity(ITrail.connection.constraint)
			ITrail.connection.constraint = nil
		end
	end,
	github = {},
	extensions = {},
	cars = {}
}

local files, _ = file.Find("trailers_extensions/*", "LUA")
local oldSystem
if SYSTEM then oldSystem = SYSTEM end
for i = 1, #files do
	SYSTEM = {}
	pcall(include, "trailers_extensions/" .. files[i])
	table.insert(Trailers.extensions, SYSTEM)
	SYSTEM = nil
end
SYSTEM = oldSystem

concommand.Add("trailer_reborn_connect", function(ply, _, _, arg)
	-- local num = tonumber(arg)
	-- if num and num < 128 and num > 0 then Trailers.Connect(ply:GetSimfphys(), num) end
	Trailers.Connect(ply:GetSimfphys())
end)
concommand.Add("trailer_reborn_disconnect", function(ply, _, _, arg)
	Trailers.Disconnect(ply:GetSimfphys())
end)
util.AddNetworkString("trailers_reborn_debug_spheres")
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
				end
			end
		end
	end
end)
hook.Add("PlayerLeaveVehicle", "trailers_reborn_player_listener",
         function(ply, veh)
	net.Start("trailers_reborn_ply_vehicle")
	net.WriteBool(false)
	net.Send(ply)
end)
hook.Add("Think", "trailers_reborn", function()
	-- for _, ent in pairs(Trailers.cars) do
	-- 	if not IsValid(ent) then table.remove(Trailers.cars, _) end
	-- end
end)
net.Receive("trailers_reborn_connect", function(len, ply)
	if IsValid(ply) then
		for _, car in pairs(Trailers.cars) do
			local simfphyscar = ply:GetSimfphys()
			if simfphys == car then
				Trailers.Connect(car)
				return
			end
		end
	else
		ErrorNoHalt("Invalid " .. ply)
	end
end)
net.Receive("trailers_reborn_disconnect", function(len, ply)
	local seat = ply:GetVehicle()
	if IsValid(seat) and IsValid(seat:GetParent()) and -- ply:GetSimfphys() - © NotAKid
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
