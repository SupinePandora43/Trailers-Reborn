declare const simfphys: any
declare function error(this: void, message: string, errorLevel?: number): void
declare namespace debug { function traceback(this: void): string }

if (!simfphys) {
	error("TR: missing: simfphys (https://steamcommunity.com/workshop/filedetails/?id=771487490)")
}
AddCSLuaFile("autorun/client/TR_debugspheres.lua")
print("loads")
function valid(this: void, safe?: number) {
	if (safe && safe > 255) error("TR: stack overflow?")
	Trailers.cars = Trailers.cars.filter((ventity) => { return IsValid(ventity.ent) })
	Trailers.cars.forEach((ventity) => {
		if (ventity.connection && !IsValid(ventity.connection.socket)) {
			ventity.connection = null as any as VConnection
		}
	})
}
function findVEntity(this: void, entity: Entity) {
	for (let i = 0; i < Trailers.cars.length; i++) {
		if (Trailers.cars[i].ent == entity)
			return Trailers.cars[i]
	}
	print("not found")
}
function getNext(this: void, ventity: VEntity | undefined) {
	if (ventity && ventity.connection) return findVEntity(ventity.connection.ent)
}
function getwhole(this: void, ventity: VEntity) {
	let buffer: VEntity[] = []
	let current: VEntity | undefined = ventity
	buffer.push(current)
	while (getNext(current) != null) {
		//if (current != null)
		//buffer.push(current)
		current = getNext(current)
		buffer.push(current as VEntity)
	}
	return buffer
}
function IsConnectable(this: void, vent1: VEntity, vent2: VEntity) {
	//return true
	if (vent1.output && vent2.input)
		return vent1.ent.LocalToWorld(vent1.output).DistToSqr(vent2.ent.LocalToWorld(vent2.input)) < 400
}
function GetConnectable(this: void, ventity: VEntity) {
	for (let i = 0; i < Trailers.cars.length; i++) {
		if (ventity == Trailers.cars[i]) continue
		if (IsConnectable(ventity, Trailers.cars[i])) return Trailers.cars[i]
	}
}
namespace Trailers {
	export let cars: VEntity[] = []
	export const systems: System[] = []
	export function Init(this: void, ventity: VEntity) {
		Trailers.cars.push(ventity)
		net.Start("trailers_reborn_debug_spheres", true)
		net.WriteTable({ ent: ventity.ent, input: ventity.input, output: ventity.output })
		net.Broadcast()
	}
	export function InitBySpawn(this: void, ent: Entity | any) {
		if (IsValid(ent)) {
			const spawnname = ent.GetSpawn_List()
			if (IsValid(ent) && spawnname != "") {
				const spawnlistentity = list.Get("simfphys_vehicles")[spawnname]
				if (spawnlistentity) {
					if (spawnlistentity.Members && spawnlistentity.Members.Trailers) {
						spawnlistentity.Members.Trailers.ent = ent
						Trailers.Init(spawnlistentity.Members.Trailers)
					} else {
						print(`TR:
	vehicle's spawnlist missing 'Members' or 'Members.Trailers'
${debug.traceback()}`)
					}
				} else {
					print(`TR:
	vehicle is missing simfphys spawn list
${debug.traceback()}`)
				}
			} else {
				print(`TR:
	${ent}
	${spawnname}
	^ something isn't valid
${debug.traceback()}`)
			}
		} else {
			print(`TR:
	${ent} is NOT valid
${debug.traceback()}`)
		}
	}
	export function Connect(this: void, ventity: VEntity | undefined) {
		if (ventity == undefined) {
			print("TR: ventity == null")
			print(debug.traceback())
			return
		}
		const whole = getwhole(ventity)
		PrintTable(whole, 0, {})
		print(whole.length)
		ventity = whole[whole.length - 1]
		const vtrailer = GetConnectable(ventity)
		if (vtrailer) {
			PrintTable(vtrailer as VEntity, 0, {})
			const ballsocketent = constraint.AdvBallsocket(ventity.ent, vtrailer.ent, 0, 0, ventity.output, vtrailer.input, 0, 0, 0, 0, 0, 360, 360, 360, 0, 0, 0, 0, 0)
			ventity.connection = { ent: vtrailer.ent, socket: ballsocketent }
		} else {
			print("TR: no connectable trailers found :C")
		}
	}
	export function ConnectEnt(this: void, entity: Entity) {
		valid()
		Trailers.Connect(findVEntity(entity))
	}
	export function Disconnect(this: void, ventity: VEntity | undefined) {
		if (ventity == null) {
			print("TR: ventity == null")
			print(debug.traceback())
			return
		}
		if (ventity.connection) {
			const whole = getwhole(ventity)
			PrintTable(whole, 0, {})
			print(whole.length)
			ventity = whole[whole.length - 2]
			SafeRemoveEntity(ventity.connection.socket)
			// WHAT ?
			ventity.connection = null as any as VConnection
		} else {
			print("TR: no connections found")
			print(debug.traceback())
		}
	}
	export function DisconnectEnt(this: void, entity: Entity) {
		valid()
		Trailers.Disconnect(findVEntity(entity))
	}
}

const files = file.Find("TR_extensions/*", "LUA")[0]
for (const system of (files as string[])) {
	print(system)
	// still WHAT?
	Trailers.systems.push(include("TR_extensions/" + system) as any as System)
}
timer.Remove("TR_system")
timer.Create("TR_system", 0.5, 0, () => {
	valid()
	for (const ventity of Trailers.cars) {
		for (const system of Trailers.systems) {
			if (system.HandleTruck) {
				system.HandleTruck(ventity)
			}
		}
	}
})
hook.Add("OnEntityCreated", "TR_handle", (ent) => {
	if (ent.GetClass() == "gmod_sent_vehicle_fphysics_base") {
		timer.Simple(0.1, () => {
			Trailers.InitBySpawn(ent)
		})
	}
})
concommand.Add("trailers_connect", (ply: Player | any) => {
	if (IsValid(ply)) {
		print(ply.GetSimfphys())
		Trailers.ConnectEnt(ply.GetSimfphys())
	} else {
		print("TR: IsValid(ply) == false")
		print(debug.traceback())
	}
})
concommand.Add("trailers_disconnect", (ply: Player | any) => {
	if (IsValid(ply)) {
		print(ply.GetSimfphys())
		Trailers.DisconnectEnt(ply.GetSimfphys())
	} else {
		print("TR: IsValid(ply) == false")
		print(debug.traceback())
	}
})
util.AddNetworkString("trailers_reborn_debug_spheres")
_G["Trailers"]= Trailers
export { }
