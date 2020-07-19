-- Lua Library inline imports
function __TS__ArrayFilter(arr, callbackfn)
    local result = {}
    do
        local i = 0
        while i < #arr do
            if callbackfn(_G, arr[i + 1], i, arr) then
                result[#result + 1] = arr[i + 1]
            end
            i = i + 1
        end
    end
    return result
end

function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

function __TS__ArrayPush(arr, ...)
    local items = {...}
    for ____, item in ipairs(items) do
        arr[#arr + 1] = item
    end
    return #arr
end

local ____exports = {}
local Trailers
resource.AddWorkshop("2083101470")
local connectedSound = file.Exists("sound/vcmod/car_connect.wav", "GAME")
local useConnectSound = CreateConVar("trailers_connectsound", "1", FCVAR_ARCHIVE, "Disables connection sound", 0, 1)
local function valid(callbackfn)
    Trailers.cars = __TS__ArrayFilter(
        Trailers.cars,
        function(____, ventity)
            return IsValid(ventity.ent)
        end
    )
    __TS__ArrayForEach(
        Trailers.cars,
        function(____, ventity)
            if ventity.connection and (not IsValid(ventity.connection.socket)) then
                ventity.connection = nil
            end
            if callbackfn then
                callbackfn(ventity)
            end
        end
    )
end
local function findVEntity(entity)
    do
        local i = 0
        while i < #Trailers.cars do
            if Trailers.cars[i + 1].ent == entity then
                return Trailers.cars[i + 1]
            end
            i = i + 1
        end
    end
    print("not found")
end
local function getNext(ventity)
    if ventity and ventity.connection then
        return findVEntity(ventity.connection.ent)
    end
end
local function getwhole(ventity)
    local buffer = {}
    local current = ventity
    __TS__ArrayPush(buffer, current)
    while getNext(current) ~= nil do
        current = getNext(current)
        __TS__ArrayPush(buffer, current)
    end
    return buffer
end
local function IsConnectableTypes(ctype1, ctype2)
    if ctype1 and ctype2 then
        return ctype1 == ctype2
    end
    return true
end
local function IsConnectable(vent1, vent2, autoconnected)
    if (autoconnected and vent1.lastDisconnected) and ((vent1.lastDisconnected + 10) > CurTime()) then
        return
    end
    if vent1.outputPos and vent2.inputPos then
        return ((IsConnectableTypes(vent1.outputType, vent2.inputType) and (function() return vent1.ent:LocalToWorld(vent1.outputPos):DistToSqr(
            vent2.ent:LocalToWorld(vent2.inputPos)
        ) < 300 end)) or (function() return false end))()
    end
end
local function GetConnectable(ventity)
    do
        local i = 0
        while i < #Trailers.cars do
            do
                if ventity == Trailers.cars[i + 1] then
                    goto __continue20
                end
                if IsConnectable(ventity, Trailers.cars[i + 1]) then
                    return Trailers.cars[i + 1]
                end
            end
            ::__continue20::
            i = i + 1
        end
    end
end
Trailers = {}
do
    Trailers.cars = {}
    Trailers.systems = {}
    function Trailers.Init(ventity)
        __TS__ArrayPush(Trailers.cars, ventity)
        net.Start("trailers_reborn_debug_spheres", true)
        net.WriteTable({ent = ventity.ent, input = ventity.inputPos, output = ventity.outputPos})
        net.Broadcast()
    end
    function Trailers.Connect(ventity, autoconnected)
        if not ventity then
            print("TR: trying to connect nothing")
            print(
                debug.traceback()
            )
            return
        end
        ventity.hydraulic = nil
        local whole = getwhole(ventity)
        ventity = whole[#whole]
        local vtrailer = GetConnectable(ventity)
        if vtrailer then
            local ballsocketent = constraint.AdvBallsocket(ventity.ent, vtrailer.ent, 0, 0, ventity.outputPos, vtrailer.inputPos, 0, 0, 0, 0, 0, 360, 360, 360, 0, 0, 0, 0, 0)
            ventity.connection = {ent = vtrailer.ent, socket = ballsocketent}
            if useConnectSound:GetBool() then
                if connectedSound then
                    ventity.ent:EmitSound("vcmod/car_connect.wav")
                else
                    ventity.ent:EmitSound(
                        ("weapons/crowbar/crowbar_impact" .. tostring(
                            math.random(1, 2)
                        )) .. ".wav"
                    )
                end
            end
            __TS__ArrayForEach(
                Trailers.systems,
                function(____, vsystem)
                    if vsystem.Connect then
                        vsystem.Connect(ventity, vtrailer)
                    end
                end
            )
        else
            print("TR: no connectable trailers found :C")
            ventity.ent:EmitSound("tr/nope.wav")
        end
    end
    function Trailers.ConnectEnt(entity)
        valid()
        Trailers.Connect(
            findVEntity(entity)
        )
    end
    function Trailers.Disconnect(ventity)
        if ventity == nil then
            print("TR: ventity == null")
            print(
                debug.traceback()
            )
            return
        end
        if ventity.connection then
            local whole = getwhole(ventity)
            ventity = whole[(#whole - 2) + 1]
            ventity.lastDisconnected = CurTime()
            for ____, system in ipairs(Trailers.systems) do
                if system.Disconnect then
                    system.Disconnect(ventity)
                end
            end
            SafeRemoveEntity(ventity.connection.socket)
            ventity.connection = nil
        else
            print("TR: no connections found")
            print(
                debug.traceback()
            )
        end
    end
    function Trailers.DisconnectEnt(entity)
        valid()
        Trailers.Disconnect(
            findVEntity(entity)
        )
    end
end
local files = ({
    file.Find("tr/systems/*", "LUA")
})[1]
print("TR: initializing systems")
print("| --- SYSTEMS ---")
for ____, system in ipairs(files) do
    print(
        "|- " .. tostring(system)
    )
    __TS__ArrayPush(
        Trailers.systems,
        include(
            "tr/systems/" .. tostring(system)
        )
    )
end
print("| --- SYSTEMS ---")
local function RestartSystemHandler()
    local autoconnect = CreateConVar("trailers_autoconnect", "1", FCVAR_ARCHIVE, "some help", 0, 1):GetBool()
    local hydrahelp = CreateConVar("trailers_hydrahelp", "1", FCVAR_ARCHIVE, "some help", 0, 1):GetBool()
    local autoconnectDist = CreateConVar("trailers_autoconnect_distance", "5", FCVAR_ARCHIVE, "maximum Distance when trailer get automatically connected", 0, 1000):GetInt()
    timer.Remove("TR_system")
    print("created timer")
    if not autoconnect then
        timer.Create(
            "TR_system",
            0.2,
            0,
            function()
                valid(
                    function(ventity)
                        for ____, system in ipairs(Trailers.systems) do
                            if system.HandleTruck then
                                system.HandleTruck(ventity)
                            end
                        end
                    end
                )
            end
        )
    elseif autoconnect and hydrahelp then
        timer.Create(
            "TR_system",
            0.2,
            0,
            function()
                valid(
                    function(ventity)
                        for ____, system in ipairs(Trailers.systems) do
                            if system.HandleTruck then
                                system.HandleTruck(ventity)
                            end
                        end
                        if (not ventity.connection) and ventity.outputPos then
                            if not ventity.phys then
                                ventity.phys = ventity.ent:GetPhysicsObject()
                            end
                            __TS__ArrayForEach(
                                Trailers.cars,
                                function(____, val)
                                    if val ~= ventity then
                                        if not val.phys then
                                            val.phys = val.ent:GetPhysicsObject()
                                        end
                                        if val.inputPos then
                                            local outputPosWorld = ventity.ent:LocalToWorld(ventity.outputPos)
                                            local inputPosWorld = val.ent:LocalToWorld(val.inputPos)
                                            local distance = outputPosWorld:DistToSqr(inputPosWorld)
                                            if IsValid(ventity.hydraulic) and (distance > 200) then
                                                print("TR: autoconnection cancelled")
                                                SafeRemoveEntity(ventity.hydraulic)
                                                ventity.hydraulic = nil
                                            elseif IsConnectable(ventity, val, true) and (distance < autoconnectDist) then
                                                print("TR: connected trailer using autoconnection")
                                                SafeRemoveEntity(ventity.hydraulic)
                                                Trailers.Connect(ventity, true)
                                                ventity.hydraulic = nil
                                            elseif IsConnectable(ventity, val, true) and (not ventity.hydraulic) then
                                                local hydraulic = constraint.Hydraulic(nil, ventity.ent, val.ent, 0, 0, ventity.outputPos, val.inputPos, 0, 0, 0, KEY_PAD_MULTIPLY, 0, 10000000, nil, false)
                                                local hydraulic2 = constraint.Hydraulic(nil, ventity.ent, val.ent, 0, 0, ventity.outputPos, val.inputPos, 0, 0, 0, KEY_PAD_MULTIPLY, 0, 10000000, nil, false)
                                                local hydraulic3 = constraint.Hydraulic(nil, ventity.ent, val.ent, 0, 0, ventity.outputPos, val.inputPos, 0, 0, 0, KEY_PAD_MULTIPLY, 0, 10000000, nil, false)
                                                numpad.Activate(nil, KEY_PAD_MULTIPLY, true)
                                                hydraulic:DeleteOnRemove(hydraulic2)
                                                hydraulic:DeleteOnRemove(hydraulic3)
                                                ventity.hydraulic = hydraulic
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
            end
        )
    else
        timer.Create(
            "TR_system",
            0.2,
            0,
            function()
                valid(
                    function(ventity)
                        for ____, system in ipairs(Trailers.systems) do
                            if system.HandleTruck then
                                system.HandleTruck(ventity)
                            end
                        end
                        if (not ventity.connection) and ventity.outputPos then
                            if not ventity.phys then
                                ventity.phys = ventity.ent:GetPhysicsObject()
                            end
                            __TS__ArrayForEach(
                                Trailers.cars,
                                function(____, val)
                                    if val ~= ventity then
                                        if not val.phys then
                                            val.phys = val.ent:GetPhysicsObject()
                                        end
                                        if val.inputPos then
                                            local outputPosWorld = ventity.ent:LocalToWorld(ventity.outputPos)
                                            local inputPosWorld = val.ent:LocalToWorld(val.inputPos)
                                            local distance = outputPosWorld:DistToSqr(inputPosWorld)
                                            if IsConnectable(ventity, val, true) and (distance < autoconnectDist) then
                                                print("TR: connected trailer using autoconnection")
                                                Trailers.Connect(ventity, true)
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
            end
        )
    end
end
RestartSystemHandler()
concommand.Add("trailers_reload_SV_systemtimer", RestartSystemHandler)
list.Set(
    "FLEX",
    "Trailers",
    function(ent, vtable)
        if istable(vtable) then
            Trailers.Init({ent = ent, inputPos = vtable.inputPos, outputPos = vtable.outputPos, inputType = vtable.inputType, outputType = vtable.outputType})
        else
            print("TR: seems like vehicle's 'Trailers' spawnlist is wrong")
        end
    end
)
concommand.Add(
    "trailers_connect",
    function(ply)
        if IsValid(ply) then
            print(
                ply:GetSimfphys()
            )
            Trailers.ConnectEnt(
                ply:GetSimfphys()
            )
        else
            print("TR: IsValid(ply) == false")
            print(
                debug.traceback()
            )
        end
    end
)
concommand.Add(
    "trailers_disconnect",
    function(ply)
        if IsValid(ply) then
            print(
                ply:GetSimfphys()
            )
            Trailers.DisconnectEnt(
                ply:GetSimfphys()
            )
        else
            print("TR: IsValid(ply) == false")
            print(
                debug.traceback()
            )
        end
    end
)
hook.Add(
    "PlayerButtonDown",
    "TR_binds",
    function(ply, button)
        if IsValid(ply) then
            if button == ply:GetInfoNum("trailers_disconnect_key", KEY_PAD_MINUS) then
                local vehicle = ply:GetSimfphys()
                if IsValid(vehicle) then
                    Trailers.DisconnectEnt(vehicle)
                end
            elseif button == ply:GetInfoNum("trailers_connect_key", KEY_PAD_PLUS) then
                local vehicle = ply:GetSimfphys()
                if IsValid(vehicle) then
                    Trailers.ConnectEnt(vehicle)
                end
            end
        end
    end
)
util.AddNetworkString("trailers_reborn_debug_spheres")
_G.Trailers = Trailers
print("TR: loaded")
return ____exports
