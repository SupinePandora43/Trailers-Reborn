AddCSLuaFile()
--Trailer Transporter
if file.Exists( "models/lonewolfie/trailers/trailer_transporter.mdl", "GAME" )then
list.Set( "simfphys_lights","lw_transporter_trailer",{
	ModernLights=true,
	L_RearLampPos=Vector(96,-23.6,3.3),
	L_RearLampAng=Angle(0,0,0),
	R_RearLampPos=Vector(96,23.6,3.3),
	R_RearLampAng=Angle(0,0,0),
	FogLight_sprites = {
	{pos = Vector(-48,294.62,142.06-0.4),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -48, 182.81, 137.15-0.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -48, 75.34, 132.21),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -48, -31.94, 128.03 -0.1 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -48, -138.79, 123.96 -0.2 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -48, -260.47, 118.93 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -47, -38.54 -0.6, 32 -0.25 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -47, -128.94, 31.6 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( -45, -218.2, 26.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( 48, 294.62, 142.06 -0.4 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( 48, 182.81, 137.15 -0.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( 48, 75.34, 132.21),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( 48, -31.94, 128.03 -0.1 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( 48, -138.79, 123.96 -0.2 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector( 48, -260.47, 118.93 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector(47, -38.54 -0.6, 32 -0.25 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector(47, -128.94, 31.6 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	{pos = Vector(45, -218.2, 26.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	},
	Rearlight_sprites = {
		Vector( -36, -277.6, 26.5 ),
		Vector( 36,  -277.6, 26.5 ),
		{pos = Vector( -43, -272.5, 34 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -43, -272.5, 37 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -43, -272.5, 40 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -43, -272.5, 43 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -43, -272.5, 46 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( -43, -272.5, 49 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 43, -272.5, 34 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 43, -272.5, 37 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 43, -272.5, 40 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 43, -272.5, 43 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 43, -272.5, 46 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
		{pos = Vector( 43, -272.5, 49 -1 ),size = 15,color=Color(255,120,0,100),material="sprites/light_ignorez"},
	},
	ems_sprites = {
		{pos = Vector( -42.38,-273 -4, 26.71 ),size = 25,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
		{pos = Vector( 42.38, -273 -4, 26.71 ),size = 25,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -49,-275, 27 + 8.5 ),size = 7,color=Color(255,120,0,255)},
		},
		Right = {
			{pos = Vector( 49,-275, 27 + 8.5 ),size = 7,color=Color(255,120,0,255)},
		}
	}
})
list.Set("simfphys_vehicles","lw_transporter_trailer",{
	Name = "Transporter Trailer",
	Model = "models/lonewolfie/trailers/trailer_transporter.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,250,35)
		}
	},
	Members = {
		Mass = 1150,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		OnTick = function(ent) 
			local physMass = 1150
			if ent:GetBodygroup(1) == 1 then
				physMass =physMass+700
			end
			if ent:GetBodygroup(2) == 1 then
				physMass=physMass+700
			end
			ent:GetPhysicsObject():SetMass(physMass)
		end,
		LightsTable = "lw_transporter_trailer",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,50,0),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Schmied Bigcargo
if file.Exists( "models/lonewolfie/trailers/trailer_schmied.mdl", "GAME" )then
list.Set( "simfphys_lights","lw_schimedbigcargo",{
	ModernLights = true,

	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),

	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos = Vector( 50, 134.2, 51.09 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector(-50, 134.2, 51.09 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},

		{pos = Vector( 22.5, 82, 50.18 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -22.5, 82, 50.18 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},

		{pos = Vector( 30, -41.5, 50.15 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -30, -41.5, 50.15 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	},
	Rearlight_sprites = { Vector( -40, -144.29, 42.65 ),
		{pos = Vector( -40, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( -43.5, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( -47, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( -36, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( -32, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},

		{pos = Vector( 40, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( 43.5, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( 47, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( 36, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},
		{pos = Vector( 32, -143, 42.65 ), size = 30, color = Color(255,0,0,100),},


		{pos = Vector( -40.32, -144, 37.25 ),size = 50,color = Color(255,0,0,100),},
		{pos = Vector( 40.32, -144, 37.25 ),size = 50,color = Color(255,0,0,100),},
	},
	ems_sprites = {
		{pos = Vector( -40.32, -144, 37.25 ),size = 50,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
		{pos = Vector( 40.32, -144, 37.25 ),size = 50,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
	},
	Reverselight_sprites = {
		{pos = Vector( -32.82, -144, 39 ),size = 15},
		{pos = Vector( -32.82, -144, 37.06 ),size = 15},
		{pos = Vector( -32.82, -144, 35 ),size = 15},

		{pos = Vector( 32.82, -144, 39 ),size = 15},
		{pos = Vector( 32.82, -144, 37.06 ),size = 15},
		{pos = Vector( 32.82, -144, 35 ),size = 15},
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -49.2,-140,52 ),size = 7,color=Color(255,50,0,255)},
			Vector( -47, -144, 39 ),
			Vector( -47, -144, 37 ),
			Vector( -47, -144, 35 ),
		},
		Right = {
			{pos = Vector( 49.2,-140, 52 ),size = 7,color=Color(255,50,0,255)},
			Vector( 47, -144, 39 ),
			Vector( 47, -144, 37 ),
			Vector( 47, -144, 35 ),
		},
	},
})
list.Set( "simfphys_vehicles","lw_schimedbigcargo",{
	Name = "Schmied Bigcargo",
	Model = "models/lonewolfie/trailers/trailer_schmied.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX={
		Trailers = {
			input = Vector(0,122,30)
		}
	},
	Members = {
		Mass = 900,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		OnTick = function(ent)
			if not (ent:GetBodygroup(2) == 0 or ent:GetBodygroup(2) ==5) then
				ent:GetPhysicsObject():SetMass(1100)
			else ent:GetPhysicsObject():SetMass(900) end
		end,
		LightsTable = "lw_schimedbigcargo",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,-40,20),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
 
		EnginePos = Vector(0,0,0),

		StrengthenSuspension = true,

		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,

		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,

		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,

		TurnSpeed = 4,

		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,

		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,

		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,

		PowerBias = 1,

		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Panel Trailer
if file.Exists("models/lonewolfie/trailers/trailer_panel.mdl","GAME")then
list.Set("simfphys_lights","lw_paneltrailer",{
	ModernLights = true,
	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),
	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos = Vector( -51.3, 194.5, 48.75 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -53.3, 75.5, 13 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -53.3, -12.5, 13 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -53.3, -101.04, 13 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -51.3, -203.94, 43 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},

		{pos = Vector( 51.3, 194.5, 48.75 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 53.3, 75.5, 13 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 53.3, -12.5, 13 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 53.3, -101.04, 13 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 51.3, -203.94, 43 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
	},
	Rearlight_sprites = {
		{pos = Vector( -24.41, -258, 20.37 ),size = 20,color=Color(255,50,0,255)},
		{pos = Vector( 24.41, -258, 20.37 ),size = 20,color=Color(255,50,0,255)},
	},
	ems_sprites = {
		{pos = Vector( -38.47, -258, 20.06 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
		{pos = Vector( 38.47, -258, 20.06 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04,},
	},
	Reverselight_sprites = {
		Vector( -10.94, -256.72, 27.21 ),
		Vector( 10.94, -256.72, 27.21 ),

		Vector( -31, -256.72, 22.25 ),
		Vector( 31, -256.72, 22.25 )
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -55.7,-258, 20.5 ),size = 7,color=Color(255,50,0,255)},

			Vector( -45.41, -256.72, 22.46 )
		},
		Right = {
			{pos = Vector( 55.7,-258, 20.5 ),size = 7,color=Color(255,50,0,255)},

			Vector( 45.41, -256.72, 22.46 )
		},
	},
})
list.Set("simfphys_vehicles","lw_trailerpanel",{
	Name = "Panel Trailer",
	Model = "models/lonewolfie/trailers/trailer_panel.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,235,32)
		}
	},
	Members = {
		Mass = 700,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		OnTick = function(ent) 
			local phys = ent:GetPhysicsObject()
			if ent:GetBodygroup(1) == 1 then
				phys:SetMass(800)
			elseif ent:GetBodygroup(1) == 2 then
				phys:SetMass(1000)
			elseif ent:GetBodygroup(1) == 3 then
				phys:SetMass(700)
			else
				phys:SetMass(525) 
			end
		end,
		LightsTable = "lw_paneltrailer",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,10,10),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Truck Transporter Trailer
if file.Exists("models/lonewolfie/trailers/trailer_truck.mdl","GAME")then
list.Set("simfphys_lights","lw_trucktrans",{
	ModernLights = true,
	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),
	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos = Vector( -53.5, 190.53, 55.8 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -53, 134.46, 26.65 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -53, 33.43, 21.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -52, -85.35, 31.71 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -52, -137.91, 31.71 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -50.5, -245.66, 18.09 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 53.5, 190.53, 55.8 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 53, 134.46, 26.65 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 53, 33.43, 21.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 52, -85.35, 31.71 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 52, -137.91, 31.71 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 50.5, -245.66, 18.09 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"}
	},
	Rearlight_sprites = {
		{pos = Vector( -45.72, -254.82, 15.93 ),size = 20,color=Color(255,0,0,200)},
		{pos = Vector( 45.72, -254.82, 15.93 ),size = 20,color=Color(255,0,0,200)}
	},
	ems_sprites = {
		{pos = Vector( -42.13, -254.1, 16.31 ),size = 20,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -37.88, -254.16, 16.28 ),size = 20,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -33.6, -254.07, 16.31 ),size = 20,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 42.13, -254.1, 16.31 ),size = 20,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 37.88, -254.16, 16.28 ),size = 20,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 33.6, -254.07, 16.31 ),size = 20,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04}
	},
	Reverselight_sprites = {
		{pos = Vector( -33.6, -254.07, 16.31 ),size = 10},
		{pos = Vector( 33.6, -254.07, 16.31 ),size = 10}
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -53.5, -251.6, 17.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
			{pos = Vector( -53.5, -253.8, 17.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
			{pos = Vector( -42.13, -254.1, 16.31 ),size = 10,color=Color(255,50,0,255)},
			{pos = Vector( -37.88, -254.16, 16.28 ),size = 10,color=Color(255,50,0,255)},
		},
		Right = {
			{pos = Vector( 53.5, -251.6, 17.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
			{pos = Vector( 53.5, -253.8, 17.5 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
			{pos = Vector( 42.13, -254.1, 16.31 ),size = 10,color=Color(255,50,0,255)},
			{pos = Vector( 37.88, -254.16, 16.28 ),size = 10,color=Color(255,50,0,255)},
		},
	},
})
list.Set("simfphys_vehicles","lw_trucktrans",{
	Name = "Truck Transporter Trailer",
	Model = "models/lonewolfie/trailers/trailer_truck.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,226,33)
		}
	},
	Members = {
		Mass = 700,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		LightsTable = "lw_trucktrans",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,20,10),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Profiliner Trailer
if file.Exists("models/lonewolfie/trailers/trailer_profiliner.mdl","GAME")then
list.Set("simfphys_lights","lw_profiliner",{
	ModernLights = true,
	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),
	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos = Vector( -48, 161.5, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -48, 48.7, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -48, -70.66, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -48, -182.63, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 48, 161.5, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 48, 48.7, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 48, -70.66, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 48, -182.63, 45.3 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"}
	},
	Rearlight_sprites = {
		{pos = Vector( 49.2,-140, 52 ),size = 7,color=Color(255,50,0,255)},
		{pos = Vector( -43.3, -265, 39.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( -43.3, -265, 38.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( -43.3, -265, 37.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( -43.3, -265, 36.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( -43.3, -265, 35.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( -43.3, -265, 34.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( 43.3, -265, 39.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( 43.3, -265, 38.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( 43.3, -265, 37.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( 43.3, -265, 36.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( 43.3, -265, 35.5 ),size = 10,color=Color(255,0,0,255)},
		{pos = Vector( 43.3, -265, 34.5 ),size = 10,color=Color(255,0,0,255)}
	},
	ems_sprites = {
		{pos = Vector( -35, -265, 37 ),size = 33,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -32, -265, 37 ),size = 33,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -38, -265, 37 ),size = 33,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 35, -265, 37 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 32, -265, 37 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 38, -265, 37 ),size = 30,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04}
	},
	Reverselight_sprites = {
		{pos = Vector( -41, -265, 39.5 ),size = 10},
		{pos = Vector( -41, -265, 38.5 ),size = 10},
		{pos = Vector( -41, -265, 37.5 ),size = 10},
		{pos = Vector( -41, -265, 36.5),size =  10},
		{pos = Vector( -41, -265, 35.5 ),size = 10},
		{pos = Vector( -41, -265, 34.5 ),size = 10},
		{pos = Vector( 41, -265, 39.5 ),size = 10},
		{pos = Vector( 41, -265, 38.5 ),size = 10},
		{pos = Vector( 41, -265, 37.5 ),size = 10},
		{pos = Vector( 41, -265, 36.5),size =  10},
		{pos = Vector( 41, -265, 35.5 ),size = 10},
		{pos = Vector( 41, -265, 34.5 ),size = 10}
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -45.7, -265, 39.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -45.7, -265, 38.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -45.7, -265, 37.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -45.7, -265, 36.5),size =  20,color=Color(255,120,0,255)},
			{pos = Vector( -45.7, -265, 35.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -45.7, -265, 34.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( -54.8,-261.6,42 ),size = 7,color=Color(255,120,0,255)}
		},
		Right = {
			{pos = Vector( 45.7, -265, 39.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 45.7, -265, 38.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 45.7, -265, 37.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 45.7, -265, 36.5),size =  20,color=Color(255,120,0,255)},
			{pos = Vector( 45.7, -265, 35.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 45.7, -265, 34.5 ),size = 20,color=Color(255,120,0,255)},
			{pos = Vector( 54.8,-261.6,42 ),size = 7,color=Color(255,120,0,255)}
		}
	}
})
list.Set("simfphys_vehicles","lw_profiliner",{
	Name = "Profiliner Trailer",
	Model = "models/lonewolfie/trailers/trailer_profiliner.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,211,30)
		}
	},
	Members = {
		Mass = 700,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		LightsTable = "lw_profiliner",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,10, 10),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Glass Trailer
if file.Exists( "models/lonewolfie/trailers/trailer_glass.mdl","GAME")then
list.Set("simfphys_lights", "lw_glasstrailer", {
	ModernLights = true,
	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),
	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos = Vector( -46, 210.87, 69.93 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -50, 105.09, 57.06 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -52, -26.82, 57 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -52, -147.57, 56.96 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},

		{pos = Vector( -41.38, -221, 63.03 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -45.97, -227, 104.75 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -46.1, -227, 137.28 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -25.54, -227, 161.96 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},


		{pos = Vector( 46, 210.87, 69.93 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 50, 105.09, 57.06 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 52, -26.82, 57 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 52, -147.57, 56.96 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		
		{pos = Vector( 41.38, -221, 63.03 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 45.97, -227, 104.75 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 46.1, -227, 137.28 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 25.54, -227, 161.96 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"}
	},
	Rearlight_sprites = {
		{pos = Vector( -42.32, -222, 20.06 ),size = 45,Colors = {Color(255,0,0,100),Color(255,0,0,100)}},
		{pos = Vector(  42.32, -222, 20.06 ),size = 45,Colors = {Color(255,0,0,100),Color(255,0,0,100)}}
	},
	ems_sprites = {
		{pos = Vector( -42.32, -222, 20.06 ),size = 25,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector(  42.32, -222, 20.06 ),size = 25,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04}
	},
	Reverselight_sprites = {
		{pos = Vector( -46.82, -221.07, 21.46 ),size = 15},
		{pos = Vector( -37.1,-221.07, 21.46 ),size = 15},
		
		{pos = Vector( 46.82, -221.07, 21.46 ),size = 15},
		{pos = Vector( 37.1,-221.07, 21.46 ),size = 15}
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -55.5, -220, 23.06 ),size = 7,color=Color(255,50,0,255)}
		},
		Right = {
			{pos = Vector( 55.5, -220, 23.06 ),size = 7,color=Color(255,50,0,255)}
		}
	}
})
list.Set("simfphys_vehicles","lw_glasstrailer",{
	Name = "Glass Trailer",
	Model = "models/lonewolfie/trailers/trailer_glass.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,194,30)
		}
	},
	Members = {
		Mass = 700,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		LightsTable = "lw_glasstrailer",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,20,10),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Livestock Trailer
if file.Exists( "models/lonewolfie/trailers/trailer_livestock.mdl", "GAME" )then
list.Set( "simfphys_lights", "lw_livestock", {
	ModernLights = true,
	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),
	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos = Vector( -49.5, 250.8, 55.9 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -49.5, 152.03, 55.9 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -49.5, 69.15, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -49.5, -29.6, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -49.5, -128.4, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( -49.5, -227.2, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 49.5, 250.8, 55.9 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 49.5, 152.03, 55.9 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 49.5, 69.15, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 49.5, -29.6, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 49.5, -128.4, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"},
		{pos = Vector( 49.5, -227.2, 43.21 ),size = 5,color=Color(255,120,0,255),material="sprites/light_ignorez"}
	},
	Rearlight_sprites = {
		{pos =  Vector( -19.3,-250, 32.5 ),size = 35,color=Color(255,0,0,200)},
		{pos =  Vector( 19.3, -250, 32.5 ),size = 35,color=Color(255,0,0,200)},
		{pos =  Vector( -16.5, -247.5, 26.5 ),size = 30,color=Color(255,0,0,240)},
		{pos =  Vector( 16.5, -247.5, 26.5 ),size =  30,color=Color(255,0,0,240)}
	},
	ems_sprites = {
		{pos = Vector( -44.88,-248,27.9 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -37.3, -248,27.9 ),size =40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -29.85,-248,27.9 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 44.88, -248,27.9 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 37.3,  -248,27.9 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 29.85, -248,27.9 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( -40.35, -252, 178 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04},
		{pos = Vector( 40.35, -252, 178 ),size = 40,Colors = {Color(255,0,0,255),Color(255,0,0,255)},Speed = 0.04}
	},
	Reverselight_sprites = {
		{pos = Vector( -22.44, -247.5, 26.5 ),size = 30},
		{pos = Vector( 22.44, -247.5, 26.5 ),size = 30}
	},
	Turnsignal_sprites = {
		Left = {
			{pos = Vector( -54.2, -244.7, 33.53 ),size = 7,color=Color(255,100,0,255)},
			{pos = Vector( -44.88, -248.3,27.8 ),size = 25,color=Color(255,100,0,255)},
			{pos = Vector( -37.3, -248.3, 27.8 ),size = 25,color=Color(255,100,0,255)},
			{pos = Vector( -29.85, -248.3,27.8 ),size = 25,color=Color(255,100,0,255)},
			{pos = Vector( -40.35, -252, 178 ),size = 25,color =Color(255,100,0,255)}
		},
		Right = {
			{pos = Vector( 54.2, -244.7, 33.53 ),size = 7,color=Color(255,100,0,255)},
			{pos = Vector( 44.88, -248.3,27.8 ),size = 25,color=Color(255,100,0,255)},
			{pos = Vector( 37.3, -248.3, 27.8 ),size = 25,color=Color(255,100,0,255)},
			{pos = Vector( 29.85, -248.3,27.8 ),size = 25,color=Color(255,100,0,255)},
			{pos = Vector( 40.35, -252, 178 ),size = 25,color =Color(255,100,0,255)}
		}
	}
})
list.Set("simfphys_vehicles","lw_livestocktrailer",{
	Name = "Livestock Trailer",
	Model = "models/lonewolfie/trailers/trailer_livestock.mdl",
	Category = "LW Trailers",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,216,30)
		}
	},
	Members = {
		Mass = 700,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		OnTick = function(ent) 
			local phys = ent:GetPhysicsObject()
			if ent:GetBodygroup(2) == 1 then
				phys:SetMass(1000)
			else
				phys:SetMass(525)
			end
		end,
		LightsTable = "lw_livestock",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 21,
		RearWheelRadius = 21,
		CustomMassCenter = Vector(0,10,10),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
--Medium Box
print("lodead")
if file.Exists( "models/lonewolfie/trailers/trailer_medbox.mdl", "GAME" )then
print("ex")
list.Set( "simfphys_lights", "lw_mediumbox", {
	ModernLights = true,
	L_RearLampPos = Vector(96,-23.6,3.3),
	L_RearLampAng = Angle(0,0,0),
	R_RearLampPos = Vector(96,23.6,3.3),
	R_RearLampAng = Angle(0,0,0),
	FogLight_sprites = {
		{pos=Vector( 49, 86, 105.5 ), color = Color(255,100,0)},
		{pos=Vector( 48, 87, 105.5 ), color = Color(255,100,0)},
		{pos=Vector( 47, 88, 105.5 ), color = Color(255,100,0)},

		{pos=Vector( 50, -98,  114 ),color=Color(255,50,50)},
		{pos=Vector( 50, -99,  114 ),color=Color(255,50,50)},
		{pos=Vector( 50, -100, 114 ),color=Color(255,50,50)},
		{pos=Vector( 50, -101, 114 ),color=Color(255,50,50)},
		{pos=Vector( 50, -98, 24   ),color=Color(255,50,50)},
		{pos=Vector( 50, -99, 24   ),color=Color(255,50,50)},
		{pos=Vector( 50, -100, 24  ),color=Color(255,50,50)},
		{pos=Vector( 50, -101, 24  ),color=Color(255,50,50)}
	},
	Rearlight_sprites = {
		Vector( 46.3, -107, 93 ),
		Vector( 46.3, -107, 91.5 ),
		Vector( 46.3, -107, 90 ),
		Vector( 46.3, -107, 88.5 ),
		Vector( 46.3, -107, 87 )
	},
	ems_sprites = {
		{pos=Vector( 46.3, -107, 93 ),  Colors = {Color(255,0,0),Color(255,0,0)},size=1, Speed = 0.04},
		{pos=Vector( 46.3, -107, 91.5 ),Colors = {Color(255,0,0),Color(255,0,0)},size=1, Speed = 0.04},
		{pos=Vector( 46.3, -107, 90 ),  Colors = {Color(255,0,0),Color(255,0,0)},size=1, Speed = 0.04},
		{pos=Vector( 46.3, -107, 88.5 ),Colors = {Color(255,0,0),Color(255,0,0)},size=1, Speed = 0.04},
		{pos=Vector( 46.3, -107, 87 ),  Colors = {Color(255,0,0),Color(255,0,0)},size=1, Speed = 0.04}
	},
	Reverselight_sprites = {
		Vector( 46.3, -107, 81 ),
		Vector( 46.3, -107, 79.5 ),
		Vector( 46.3, -107, 78 ),
		Vector( 46.3, -107, 77.5 ),
		Vector( 46.3, -107, 76 )
	}
})
list.Set("simfphys_vehicles","lw_mediumbox",{
	Name = "Medium Box Trailer",
	Model = "models/lonewolfie/trailers/trailer_medbox.mdl",
	Category = "LW Trailers123",
	SpawnOffset = Vector(0,0,0),
	SpawnAngleOffset = 0,
	FLEX = {
		Trailers = {
			input = Vector(0,170,23)
		}
	},
	Members = {
		Mass = 700,
		OnSpawn = function(ent)
			ent:Lock()
		end,
		LightsTable = "lw_mediumbox",
		BulletProofTires = false,
		CustomSteerAngle = 0,
		AirFriction = -3000,
		FrontWheelRadius = 15,
		RearWheelRadius = 15,
		CustomMassCenter = Vector(0,10,10),
		SeatOffset = Vector(0,0,0),
		SeatPitch = 0,
		SeatYaw = -90,
		MaxHealth = 9999999999,
		IsArmored = false,
		EnginePos = Vector(0,0,0),
		StrengthenSuspension = true,
		FrontHeight = 4,
		FrontWheelMass = 200,
		FrontConstant = 25000,
		FrontDamping = 2000,
		FrontRelativeDamping = 2500,
		RearHeight = 4,
		RearWheelMass = 200,
		RearConstant = 25000,
		RearDamping = 2000,
		RearRelativeDamping = 2500,
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		TurnSpeed = 4,
		MaxGrip = 79,
		Efficiency = 0.9,
		GripOffset = -3,
		BrakePower = 0,
		IdleRPM = 0,
		LimitRPM = 0,
		Revlimiter = false,
		PeakTorque = 0,
		PowerbandStart = 0,
		PowerbandEnd = 0,
		Turbocharged = false,
		Supercharged = false,
		Backfire = false,
		FuelFillPos = Vector(0,0,0),
		FuelType = FUELTYPE_NONE,
		FuelTankSize = 0,
		PowerBias = 1,
		EngineSoundPreset = 1,
		snd_pitch = 0.5,
		snd_idle = "common/null.wav",
		snd_low = "common/null.wav",
		snd_low_revdown = "common/null.wav",
		snd_low_pitch = 1,
		snd_mid = "common/null.wav",
		snd_mid_gearup = "common/null.wav",
		snd_mid_geardown = "common/null.wav",
		snd_mid_pitch = 2,
		snd_horn = "common/null.wav",
		snd_blowoff = "common/null.wav",
		snd_backfire = "common/null.wav",
		DifferentialGear = 0.4,
		Gears = {-0.2,0,0.1}
	}
})
end
print("YES")
