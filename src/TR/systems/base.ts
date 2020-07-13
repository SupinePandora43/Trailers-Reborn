const SYSTEM: System = {
	HandleTruck(this: void, ventity: VEntity | any) {
		if (ventity.connection) {
			const truck = ventity.ent as any
			const trailer = ventity.connection.ent as any
			// TODO: better variant
			trailer.SetActive(true)

			let brakes = truck.GetIsBraking()
			// pretty useless
			if (truck.PressedKeys["S"] === 1) {
				brakes = true
			} else if (truck.PressedKeys["joystick_brake"] === 1) {
				brakes = true
			}
			let reverseLights = false
			if (truck.GearRatio < 0) {
				reverseLights = true
			}
			trailer.SetEMSEnabled((!reverseLights) && brakes)
			trailer.SetLightsEnabled(truck.GetLightsEnabled())
			trailer.SetFogLightsEnabled(truck.GetFogLightsEnabled())

			// Disabling Brakes
			trailer.StartEngine()
			// Reverse Lights
			// Brakes
			trailer.PressedKeys["joystick_brake"] = (reverseLights || brakes) ? 1 : 0

			if (trailer.PressedKeys["joystick_brake"] === 1) {
				trailer.PressedKeys["joystick_throttle"] = 0
				//trailer.SetGear(1)
			} else if (trailer.PressedKeys["joystick_brake"] === 0) {
				trailer.PressedKeys["joystick_throttle"] = 1
				//trailer.SetGear(3)
			}

			// simfphys automatically clamps value
			trailer.ForceGear(truck.CurrentGear)

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

			trailer.SetGear(1)

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
