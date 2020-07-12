const SYSTEM: System = {
	HandleTruck(this: void, ventity: VEntity | any) {
		if (ventity.connection) {
			const truck = ventity.ent as any
			const trailer = ventity.connection.ent as any
			trailer.trailers_systems_base_active = truck.EngineActive() || truck.trailers_systems_base_active
			trailer.SetActive(trailer.trailers_systems_base_active)
			trailer.SetActive(true)

			const brakes = truck.GetIsBraking() // truck.GetHandBrakeEnabled() - Handbrakes does NOT enable EMS lights
			trailer.SetEMSEnabled(brakes)
			trailer.SetLightsEnabled(truck.GetLightsEnabled())
			trailer.SetFogLightsEnabled(truck.GetFogLightsEnabled())

			// Disabling Brakes
			trailer.PressedKeys["joystick_throttle"] = truck.EngineActive() && !(truck.GearRatio < 0) ? 1 : 0
			// Reverse Lights
			// Brakes
			trailer.PressedKeys["joystick_brake"] = truck.PressedKeys["S"] ? 1 : truck.PressedKeys["joystick_brake"]
			// Handbrake
			trailer.PressedKeys["joystick_handbrake"] = truck.PressedKeys["Space"] ? 1 : truck.PressedKeys["joystick_handbrake"]
			// TODO: send new turn direction only when it get changed
			net.Start("simfphys_turnsignal")
			net.WriteEntity(trailer)
			net.WriteInt(truck.TSMode || 0, 32)
			net.Broadcast()
			trailer.TSMode = truck.TSMode // allows long train-like connections work properly
		}
	},
	Disconnect(this: void, ventity: VEntity) {
		if (ventity.connection && IsValid(ventity.connection.ent)) {
			const trailer = ventity.connection.ent as any
			trailer.SetActive(false)

			trailer.SetEMSEnabled(false)
			trailer.SetLightsEnabled(false)
			trailer.SetFogLightsEnabled(false)

			trailer.PressedKeys["joystick_throttle"] = 0
			trailer.PressedKeys["joystick_brake"] = 0
			trailer.PressedKeys["joystick_handbrake"] = 0
		}
	}
}
export = SYSTEM
