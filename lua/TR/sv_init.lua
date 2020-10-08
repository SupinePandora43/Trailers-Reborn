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
local useConnectSound = CreateConVar("trailers_connectsound", "1", FCVAR_ARCHIVE, "Use connection sound?", 0, 1)
sound.Add({channel = CHAN_STATIC, name = "TR_connect", sound = "tr/trailer_connection.wav"})
local function valid(callbackfn)
    Trailers.cars = __TS__ArrayFilter(
        Trailers.cars,
        function(____, ventity)
            return IsValid(ventity.ent)
        end
    )
    if callbackfn then
        __TS__ArrayForEach(
            Trailers.cars,
            function(____, ventity)
                if ventity.connection and (not IsValid(ventity.connection.socket)) then
                    ventity.connection = nil
                end
                callbackfn(ventity)
            end
        )
    else
        __TS__ArrayForEach(
            Trailers.cars,
            function(____, ventity)
                if ventity.connection and (not IsValid(ventity.connection.socket)) then
                    ventity.connection = nil
                end
            end
        )
    end
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
    print("TR: not found")
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
local function GetConnectable(ventity, autoconnected)
    do
        local i = 0
        while i < #Trailers.cars do
            do
                if ventity == Trailers.cars[i + 1] then
                    goto __continue23
                end
                if IsConnectable(ventity, Trailers.cars[i + 1], autoconnected) then
                    return Trailers.cars[i + 1]
                end
            end
            ::__continue23::
            i = i + 1
        end
    end
end
Trailers = {}
do
    Trailers.cars = {}
    Trailers.systems = {}
    function Trailers.Init(ventity)
        if ventity.disableUse then
            ventity.ent.Use = nil
        end
        if ventity.disableUseOnWheels then
            timer.Simple(
                0.5,
                function()
                    if IsValid(ventity.ent) then
                        do
                            local i = 0
                            while i < #ventity.ent.Wheels do
                                local wheel = ventity.ent.Wheels[i + 1]
                                wheel.Use = nil
                                i = i + 1
                            end
                        end
                    end
                end
            )
        end
        __TS__ArrayPush(Trailers.cars, ventity)
        net.Start("trailers_reborn_debug_spheres")
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
            if useConnectSound then
                sound.Play(
                    "TR_connect",
                    ventity.ent:LocalToWorld(ventity.outputPos),
                    75,
                    100,
                    1
                )
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
    print("TR: created system timer")
    timer.Create(
        "TR_autoconnect",
        0.1,
        0,
        function()
            valid(
                function(ventity)
                    if not ventity.connection then
                        local car = GetConnectable(ventity, true)
                        if car then
                            ventity.phys = ventity.ent:GetPhysicsObject()
                            car.phys = car.ent:GetPhysicsObject()
                            local outputPos = ventity.ent:LocalToWorld(ventity.outputPos)
                            local inputPos = car.ent:LocalToWorld(car.inputPos)
                            local targetVec = inputPos - outputPos
                            targetVec:Div(2)
                            local truckTargetPos = ventity.ent:GetPos()
                            truckTargetPos:Add(targetVec)
                            targetVec:Mul(-1)
                            local trailerTargetPos = car.ent:GetPos()
                            trailerTargetPos:Add(targetVec)
                            ventity.ent:SetPos(truckTargetPos)
                            car.ent:SetPos(trailerTargetPos)
                            Trailers.Connect(ventity, true)
                        end
                    end
                end
            )
        end
    )
    print("TR: created autoconnect timer")
end
RestartSystemHandler()
concommand.Add("trailers_reload_SV_systemtimer", RestartSystemHandler)
list.Set(
    "FLEX",
    "Trailers",
    function(ent, vtable)
        if istable(vtable) then
            vtable.ent = ent
            Trailers.Init(vtable)
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
