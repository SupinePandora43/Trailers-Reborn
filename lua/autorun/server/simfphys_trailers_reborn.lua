if not simfphys then
    error(
        "Install SimFphys first https://steamcommunity.com/workshop/filedetails/?id=771487490")
end

trailers_reborn = {
    Init = function(veh, pos, size, vehtype, hingetype, extension) -- type: truck, dolly, trailer. hingetype: ball, axis
        if CLIENT then return end
        if vehtype == "truck" then -- ша
            table.insert(trailers_reborn.trucks, {
                ent = veh,
                pos = pos,
                size = size,
                hignetype = hingetype,
                extension = extension,
                connection = {}
            })
        elseif vehtype == dolly then
            table.insert(trailers_reborn.dollys, {
                ent = veh,
                pos = pos,
                size = size,
                hingetype = hingetype,
                extension = extension,
                connection = {}
            })
        elseif vehtype == trailer then
            table.insert(trailers_reborn.trailers, {
                ent = veh,
                pos = pos,
                size = size,
                hingetype = hingetype,
                extension = extension,
                connection = {}
            })
        else
            error(vehtype .. " ISNT VALID")
        end
    end,
    Register = function(name, extension)
        if CLIENT then return end
        trailers_reborn.extensions[name] = extension
	end,
	Connect = function(truck, connection)
		for _, value in pairs(trailers_reborn.trucks) do
			if truck == value.ent then
				if value.connection[connection] then

				end
			end
		end
	end,
    trucks = {},
    dollys = {},
    trailers = {},
    extensions = {}
}

util.AddNetworkString("trailers_reborn_ply_vehicle")
util.AddNetworkString("trailers_reborn_connect")
util.AddNetworkString("trailers_reborn_disconnect")
hook.Add("PlayerEnteredVehicle", "trailers_reborn_player_listener",
         function(ply, veh)
    print(veh)
    if veh:IsValid() and simfphys.IsCar(veh:GetParent()) then
        for _, trucki in pairs(trailers_reborn.trucks) do
            if trucki.ent:GetDriverSeat() == veh then
                if veh:GetDriver() == ply then
                    net.Start("trailers_reborn_ply_vehicle")
                    net.WriteBool(true)
                    net.Send(ply)
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
hook.Add("Tick", "trailers_reborn_tick", function()
    for key, value in pairs(trailers_reborn.trucks) do
        if not IsValid(value.ent) then
            table.remove(trailers_reborn.trucks, key)
        end
    end
    for key, value in pairs(trailers_reborn.dollys) do
        if not IsValid(value.ent) then
            table.remove(trailers_reborn.dollys, key)
        end
    end
    for key, value in pairs(trailers_reborn.trailers) do
        if not IsValid(value.ent) then
            table.remove(trailers_reborn.trailers, key)
        end
    end
end)
net.Receive("trailers_reborn_connect", function(len, ply)
    local seat = ply:GetVehicle()
    if IsValid(seat) and IsValid(seat:GetParent()) and
        simfphys.IsCar(seat:GetParent()) then
        for _, trucki in pairs(trailers_reborn.trucks) do
            if trucki.ent == seat:GetParent() then
                if seat:GetParent():GetDriver() == ply then
                    print(net.ReadUInt(8))
                end
            end
        end
    else
        ErrorNoHalt("You're not in vehicle ".. ply)
    end
end)
net.Receive("trailers_reborn_disconnect", function(len, ply)
    local seat = ply:GetVehicle()
    if IsValid(seat) and IsValid(seat:GetParent()) and
        simfphys.IsCar(seat:GetParent()) then
        for _, trucki in pairs(trailers_reborn.trucks) do
            if trucki.ent == seat:GetParent() then
				if seat:GetParent():GetDriver() == ply then
                    print(net.ReadUInt(8)) -- 254 trailers max
                end
            end
        end
    else
        ErrorNoHalt("You're not in vehicle ".. ply)
    end
end)
