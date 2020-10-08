//////////////////////////
// Trailers Reborn (TR) //
// Server code          //
//////////////////////////

// download sounds to client

/*
resource.AddFile("sound/tr/trailer_connection.wav")
resource.AddFile("sound/tr/nope.wav")
// */

resource.AddWorkshop("2083101470")

const useConnectSound = CreateConVar("trailers_connectsound", "1", FCVAR.FCVAR_ARCHIVE, "Use connection sound?", 0, 1)
// TODO: it is should be in shared?
sound.Add({
	channel: CHAN.CHAN_STATIC,
	name: "TR_connect",
	sound: "tr/trailer_connection.wav"
} as SoundData)

function valid(this: void, callbackfn?: (this: void, ventity: VEntity) => void) {
	Trailers.cars = Trailers.cars.filter((ventity) => { return IsValid(ventity.ent) })
	// this thing born when you compile something in production mode
	// it used for performance, cuz checking "callbackfn" each time is slow
	if (callbackfn) {
		Trailers.cars.forEach((ventity) => {
			if (ventity.connection && !IsValid(ventity.connection.socket)) {
				ventity.connection = null as any as VConnection
			}
			callbackfn(ventity)
		})
	} else {
		Trailers.cars.forEach((ventity) => {
			if (ventity.connection && !IsValid(ventity.connection.socket)) {
				ventity.connection = null as any as VConnection
			}
		})
	}
}
// TODO: make it global
function findVEntity(this: void, entity: Entity) {
	for (let i = 0; i < Trailers.cars.length; i++) {
		if (Trailers.cars[i].ent == entity)
			return Trailers.cars[i]
	}
	// TODO: is custom logging system needed?
	print("TR: not found")
}
function getNext(this: void, ventity: VEntity | undefined) {
	if (ventity && ventity.connection) return findVEntity(ventity.connection.ent)
}
function getwhole(this: void, ventity: VEntity) {
	let buffer: VEntity[] = []
	let current: VEntity | undefined = ventity
	buffer.push(current)
	while (getNext(current) != null) {
		current = getNext(current)
		buffer.push(current as VEntity)
	}
	return buffer
}
function IsConnectableTypes(this: void, ctype1?: string, ctype2?: string) {
	if (ctype1 && ctype2) {
		return ctype1 === ctype2
	}
	return true
}
function IsConnectable(this: void, vent1: VEntity, vent2: VEntity, autoconnected?: boolean) {
	if (autoconnected && vent1.lastDisconnected && vent1.lastDisconnected + 10 > CurTime()) return // "if(null)" equals to "if(false)", doesn't return, because returning nothing is faster than bool (i hope)
	if (vent1.outputPos && vent2.inputPos)
		return IsConnectableTypes(vent1.outputType, vent2.inputType) ? vent1.ent.LocalToWorld(vent1.outputPos).DistToSqr(vent2.ent.LocalToWorld(vent2.inputPos)) < 300 : false
}
function GetConnectable(this: void, ventity: VEntity, autoconnected?: boolean) {
	for (let i = 0; i < Trailers.cars.length; i++) {
		if (ventity == Trailers.cars[i]) continue
		if (IsConnectable(ventity, Trailers.cars[i], autoconnected)) return Trailers.cars[i]
	}
}
namespace Trailers {
	export let cars: VEntity[] = []
	export const systems: System[] = []
	export function Init(this: void, ventity: VEntity) {
		if (ventity.disableUse) {
			ventity.ent.Use = null as any
		}
		if (ventity.disableUseOnWheels) {
			timer.Simple(0.5, () => {
				if (IsValid(ventity.ent))
					for (let i = 0; i < ((ventity.ent as any).Wheels as Entity[]).length; i++) {
						const wheel = ((ventity.ent as any).Wheels as Entity[])[i]
						wheel.Use = null as any
					}
			})
		}

		Trailers.cars.push(ventity)
		net.Start("trailers_reborn_debug_spheres")
		net.WriteTable({ ent: ventity.ent, input: ventity.inputPos, output: ventity.outputPos })
		net.Broadcast()
	}
	// TODO: wt is this schit???
	export function Connect(this: void, ventity: VEntity, autoconnected?: boolean) {
		if (!ventity) {
			print("TR: trying to connect nothing")
			print(debug.traceback())
			return
		}
		ventity.hydraulic = undefined
		const whole = getwhole(ventity)
		ventity = whole[whole.length - 1]
		const vtrailer = GetConnectable(ventity) as VEntity
		if (vtrailer) {
			const ballsocketent = constraint.AdvBallsocket(ventity.ent, vtrailer.ent, 0, 0, ventity.outputPos as Vector, vtrailer.inputPos as Vector, 0, 0, 0, 0, 0, 360, 360, 360, 0, 0, 0, 0, 0)
			ventity.connection = { ent: vtrailer.ent, socket: ballsocketent }
			if (useConnectSound)
				sound.Play("TR_connect", ventity.ent.LocalToWorld(ventity.outputPos as Vector), 75, 100, 1)
			Trailers.systems.forEach((vsystem) => {
				if (vsystem.Connect) {
					vsystem.Connect(ventity, vtrailer)
				}
			})
		} else {
			print("TR: no connectable trailers found :C")
			ventity.ent.EmitSound("tr/nope.wav")
		}
	}
	export function ConnectEnt(this: void, entity: Entity) {
		valid()
		Trailers.Connect(findVEntity(entity) as VEntity)
	}
	export function Disconnect(this: void, ventity: VEntity | undefined) {
		if (ventity == null) {
			print("TR: ventity == null")
			print(debug.traceback())
			return
		}
		if (ventity.connection) {
			const whole = getwhole(ventity)
			ventity = whole[whole.length - 2] // mafs
			ventity.lastDisconnected = CurTime()
			for (const system of Trailers.systems) {
				if (system.Disconnect) {
					system.Disconnect(ventity)
				}
			}
			SafeRemoveEntity((ventity.connection as VConnection).socket)
			// WHAT ?
			ventity.connection = null as any as VConnection
		} else {
			print("TR: no connections found")
		}
	}
	export function DisconnectEnt(this: void, entity: Entity) {
		valid()
		Trailers.Disconnect(findVEntity(entity))
	}
}

/**         */
/** SYSTEMS */
/**         */
const files = file.Find("tr/systems/*", "LUA")[0]
print("TR: initializing systems")
print("| --- SYSTEMS ---")
for (const system of (files as string[])) {
	print("|- " + system)
	Trailers.systems.push(include("tr/systems/" + system) as any as System)
}
print("| --- SYSTEMS ---")

// would be nice to have #define
// but const enum works same :D
const enum SIZES {
	HYDRAREMOVE = 200
}

/**              */
/** SYSTEM timer */
/**              */
function RestartSystemHandler(this: void) {
	const autoconnect = CreateConVar("trailers_autoconnect", "1", FCVAR.FCVAR_ARCHIVE, "some help", 0, 1).GetBool()
	const hydrahelp = CreateConVar("trailers_hydrahelp", "1", FCVAR.FCVAR_ARCHIVE, "some help", 0, 1).GetBool()
	const autoconnectDist = CreateConVar("trailers_autoconnect_distance", "5", FCVAR.FCVAR_ARCHIVE, "maximum Distance when trailer get automatically connected", 0, 1000).GetInt()
	timer.Remove("TR_system")
	timer.Create("TR_system", 0.2, 0, () => {
		valid((ventity: VEntity) => {
			for (const system of Trailers.systems) {
				if (system.HandleTruck) {
					system.HandleTruck(ventity)
				}
			}
		})
	})
	print("TR: created system timer")
	timer.Create("TR_autoconnect", 0.1, 0, () => {
		valid((ventity: VEntity) => {
			// Check if already have connection
			if (!ventity.connection) {
				// find connectable entity
				const car = GetConnectable(ventity, true)
				if (car) {
					ventity.phys = ventity.ent.GetPhysicsObject()
					car.phys = car.ent.GetPhysicsObject()

					const outputPos = ventity.ent.LocalToWorld(ventity.outputPos as Vector)
					const inputPos = car.ent.LocalToWorld(car.inputPos as Vector)
					// difference between connection positions
					const targetVec = ((inputPos as any as number) - (outputPos as any as number)) as any as Vector

					// divide by 2, 50% for truck, 50% for trailer
					targetVec.Div(2)
					const truckTargetPos = ventity.ent.GetPos()
					truckTargetPos.Add(targetVec)

					// but it shared for them, we need to multiply by -1, to make it in opposite direction
					targetVec.Mul(-1)
					const trailerTargetPos = car.ent.GetPos()
					trailerTargetPos.Add(targetVec)

					ventity.ent.SetPos(truckTargetPos)
					car.ent.SetPos(trailerTargetPos)
					Trailers.Connect(ventity, true)
				}
			}
		})
	})
	print("TR: created autoconnect timer")
}
RestartSystemHandler()
concommand.Add("trailers_reload_SV_systemtimer", RestartSystemHandler)
list.Set("FLEX", "Trailers", (ent, vtable) => {
	if (istable(vtable)) {
		vtable.ent = ent
		Trailers.Init(vtable)
	} else {
		print("TR: seems like vehicle's 'Trailers' spawnlist is wrong")
	}
})
concommand.Add("trailers_connect", (ply: Player | any) => {
	if (IsValid(ply)) {
		print(ply.GetSimfphys())
		Trailers.ConnectEnt(ply.GetSimfphys())
	} else {
		print("TR: IsValid(ply) == false")
	}
})
concommand.Add("trailers_disconnect", (ply: Player | any) => {
	if (IsValid(ply)) {
		print(ply.GetSimfphys())
		Trailers.DisconnectEnt(ply.GetSimfphys())
	} else {
		print("TR: IsValid(ply) == false")
	}
})
/////////////////////////////////////////////////////
/// PREDICTED ///////////////////////////////////////
/// allowed to use only on server (in singleplayer)//
/// / / / / / / / / / / / / / / / / / / / / / / / ///
/// if used on client use RunConsoleCommand /////////
/////////////////////////////////////////////////////
hook.Add("PlayerButtonDown", "TR_binds", (ply: Player | any, button: number) => {
	if (IsValid(ply)) {
		if (button == ply.GetInfoNum("trailers_disconnect_key", KEY.KEY_PAD_MINUS)) {
			const vehicle = ply.GetSimfphys()
			if (IsValid(vehicle)) {
				Trailers.DisconnectEnt(vehicle)
			}
		}
		else if (button == ply.GetInfoNum("trailers_connect_key", KEY.KEY_PAD_PLUS)) {
			const vehicle = ply.GetSimfphys()
			if (IsValid(vehicle)) {
				Trailers.ConnectEnt(vehicle)
			}
		}
	}
})
util.AddNetworkString("trailers_reborn_debug_spheres")
_G["Trailers"] = Trailers
print("TR: loaded")
export { }
