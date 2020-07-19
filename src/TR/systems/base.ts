const SYSTEM: System = {
	HandleTruck(this: void, ventity: VEntity | any) {
		if (ventity.connection) {
			const truck = ventity.ent as any
			const trailer = ventity.connection.ent as any

			let brakes = truck.GetIsBraking()
			// pretty useless
			if (truck.PressedKeys["S"] === 1) {
				brakes = true
			} else if (truck.PressedKeys["joystick_brake"] === 1) {
				brakes = true
			}
			let reverseLights = false
			if ((truck.GearRatio || 0) < 0) {
				reverseLights = true
			}
			trailer.SetEMSEnabled((!reverseLights) && brakes)
			trailer.SetLightsEnabled(truck.GetLightsEnabled())
			trailer.SetFogLightsEnabled(truck.GetFogLightsEnabled())

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
			trailer.PressedKeys["joystick_handbrake"] = truck.PressedKeys["Space"] ? 1 : truck.PressedKeys["joystick_handbrake"] || 0

			if (trailer.TSMode != truck.TSMode) {
				net.Start("simfphys_turnsignal")
				net.WriteEntity(trailer)
				net.WriteInt(truck.TSMode || 0, 32)
				net.Broadcast()
			}
			// allows infinity stack of trailers toggle turn lights
			trailer.TSMode = truck.TSMode
		}
	},
	Connect(this: void, ventity: VEntity, vtrailer: VEntity) {
		print("Connected")
		const trailer = vtrailer.ent as any
		// Disabling Brakes
		// TODO: better variant
		trailer.SetActive(true)
		trailer.StartEngine()
	},
	// https://www.youtube.com/watch?v=PMbAAcO7i6o
	Disconnect(this: void, ventity: VEntity) {
		if (ventity.connection && IsValid(ventity.connection.ent)) {
			print("disconnected")
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
