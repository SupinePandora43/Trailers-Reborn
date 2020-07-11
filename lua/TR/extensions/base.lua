local SYSTEM = {
    HandleTruck = function(ventity)
        if ventity.connection then
            local truck = ventity.ent
            local trailer = ventity.connection.ent
            trailer.trailers_systems_base_active = truck:EngineActive() or truck.trailers_systems_base_active
            trailer:SetActive(trailer.trailers_systems_base_active)
            trailer:SetActive(true)
            local brakes = truck:GetIsBraking()
            trailer:SetEMSEnabled(brakes)
            trailer:SetLightsEnabled(
                truck:GetLightsEnabled()
            )
            trailer:SetFogLightsEnabled(
                truck:GetFogLightsEnabled()
            )
            trailer.PressedKeys.joystick_throttle = ((truck:EngineActive() and (not (truck.GearRatio < 0))) and 1) or 0
            trailer.PressedKeys.joystick_brake = (truck.PressedKeys.S and 1) or truck.PressedKeys.joystick_brake
            trailer.PressedKeys.joystick_handbrake = (truck.PressedKeys.Space and 1) or truck.PressedKeys.joystick_handbrake
            local turndirection = truck.TSMode or 0
            local oldturndirection = truck.TRoldturndirection or turndirection
            if turndirection ~= oldturndirection then
                trailer.TSMode = turndirection
                net.Start("simfphys_turnsignal")
                net.WriteEntity(trailer)
                net.WriteInt(turndirection, 32)
                net.Broadcast()
                truck.TRoldturndirection = turndirection
            end
        end
    end,
    Disconnect = function(ventity)
        if ventity.connection and IsValid(ventity.connection.ent) then
            local trailer = ventity.connection.ent
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
