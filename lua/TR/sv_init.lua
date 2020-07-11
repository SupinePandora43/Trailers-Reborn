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
local function IsConnectable(vent1, vent2)
    if vent1.output and vent2.input then
        return vent1.ent:LocalToWorld(vent1.output):DistToSqr(
            vent2.ent:LocalToWorld(vent2.input)
        ) < 400
    end
end
local function GetConnectable(ventity)
    do
        local i = 0
        while i < #Trailers.cars do
            do
                if ventity == Trailers.cars[i + 1] then
                    goto __continue17
                end
                if IsConnectable(ventity, Trailers.cars[i + 1]) then
                    return Trailers.cars[i + 1]
                end
            end
            ::__continue17::
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
        net.WriteTable({ent = ventity.ent, input = ventity.input, output = ventity.output})
        net.Broadcast()
    end
    function Trailers.Connect(ventity)
        if ventity == nil then
            print("TR: ventity == null")
            print(
                debug.traceback()
            )
            return
        end
        local whole = getwhole(ventity)
        ventity = whole[#whole]
        local vtrailer = GetConnectable(ventity)
        if vtrailer then
            PrintTable(vtrailer, 0, {})
            local ballsocketent = constraint.AdvBallsocket(ventity.ent, vtrailer.ent, 0, 0, ventity.output, vtrailer.input, 0, 0, 0, 0, 0, 360, 360, 360, 0, 0, 0, 0, 0)
            ventity.connection = {ent = vtrailer.ent, socket = ballsocketent}
        else
            print("TR: no connectable trailers found :C")
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
            PrintTable(whole, 0, {})
            print(#whole)
            ventity = whole[(#whole - 2) + 1]
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
    file.Find("TR/extensions/*", "LUA")
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
            "TR/extensions/" .. tostring(system)
        )
    )
end
print("| --- SYSTEMS ---")
timer.Remove("TR_system")
timer.Create(
    "TR_system",
    0.5,
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
list.Set(
    "FLEX",
    "Trailers",
    function(ent, vtable)
        if istable(vtable) then
            Trailers.Init({ent = ent, input = vtable.input, output = vtable.output})
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
util.AddNetworkString("trailers_reborn_debug_spheres")
_G.Trailers = Trailers
print("TR: loaded")
return ____exports
