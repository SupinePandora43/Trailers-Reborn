local SYSTEM = {
    HandleTruck = function(ventity)
        if ventity.connection then
            local truck = ventity.ent
            local trailer = ventity.connection.ent
            local brakes = truck:GetIsBraking()
            if truck.PressedKeys.S == 1 then
                brakes = true
            elseif truck.PressedKeys.joystick_brake == 1 then
                brakes = true
            end
            local reverseLights = false
            if (truck.GearRatio or 0) < 0 then
                reverseLights = true
            end
            trailer:SetEMSEnabled((not reverseLights) and brakes)
            trailer:SetLightsEnabled(
                truck:GetLightsEnabled()
            )
            trailer:SetFogLightsEnabled(
                truck:GetFogLightsEnabled()
            )
            trailer.PressedKeys.joystick_brake = ((reverseLights or brakes) and 1) or 0
            if trailer.PressedKeys.joystick_brake == 1 then
                trailer.PressedKeys.joystick_throttle = 0
            elseif trailer.PressedKeys.joystick_brake == 0 then
                trailer.PressedKeys.joystick_throttle = 1
            end
            trailer:ForceGear(truck.CurrentGear)
            trailer.PressedKeys.joystick_handbrake = (truck.PressedKeys.Space and 1) or (truck.PressedKeys.joystick_handbrake or 0)
            if trailer.TSMode ~= truck.TSMode then
                net.Start("simfphys_turnsignal")
                net.WriteEntity(trailer)
                net.WriteInt(truck.TSMode or 0, 32)
                net.Broadcast()
            end
            trailer.TSMode = truck.TSMode
        end
    end,
    Connect = function(ventity, vtrailer)
        print("Connected")
        local trailer = vtrailer.ent
        trailer:SetActive(true)
    end,
    Disconnect = function(ventity)
        if ventity.connection and IsValid(ventity.connection.ent) then
            print("disconnected")
            local trailer = ventity.connection.ent
            trailer:SetGear(1)
            trailer:SetActive(false)
            trailer:SetEMSEnabled(false)
            trailer:SetLightsEnabled(false)
            trailer:SetFogLightsEnabled(false)
            trailer.PressedKeys.joystick_throttle = 0
            trailer.PressedKeys.joystick_brake = 0
            trailer.PressedKeys.joystick_handbrake = 0
        end
    end
}
local ____exports = SYSTEM
return ____exports
