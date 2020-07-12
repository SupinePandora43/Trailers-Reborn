local SYSTEM = {
    HandleTruck = function(ventity)
        if ventity.connection then
            local truck = ventity.ent
            local trailer = ventity.connection.ent
            trailer:SetActive(true)
            local brakes = truck:GetIsBraking()
            trailer:SetEMSEnabled(brakes)
            trailer:SetLightsEnabled(
                truck:GetLightsEnabled()
            )
            trailer:SetFogLightsEnabled(
                truck:GetFogLightsEnabled()
            )
            trailer:StartEngine()
            trailer:SetGear(2)
            trailer.PressedKeys.joystick_throttle = ((truck.GearRatio > 0) and (((truck:GetIsBraking() == true) and 0) or 1)) or 0
            trailer.PressedKeys.joystick_brake = (truck.PressedKeys.S and 1) or truck.PressedKeys.joystick_brake
            trailer.PressedKeys.joystick_handbrake = (truck.PressedKeys.Space and 1) or truck.PressedKeys.joystick_handbrake
            net.Start("simfphys_turnsignal")
            net.WriteEntity(trailer)
            net.WriteInt(truck.TSMode or 0, 32)
            net.Broadcast()
            trailer.TSMode = truck.TSMode
        end
    end,
    Disconnect = function(ventity)
        if ventity.connection and IsValid(ventity.connection.ent) then
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
