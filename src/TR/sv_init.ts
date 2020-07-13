//declare const simfphys: any
//declare function error(this: void, message: string, errorLevel?: number): void
declare namespace debug { function traceback(this: void): string }
// reborn loads faster than simfphys :C
// error("TR: missing: simfphys (https://steamcommunity.com/workshop/filedetails/?id=771487490)")
resource.AddFile("sound/tr/nope.wav")
function valid(this: void, callbackfn?: (this: void, ventity: VEntity) => void) {
	Trailers.cars = Trailers.cars.filter((ventity) => { return IsValid(ventity.ent) })
	Trailers.cars.forEach((ventity) => {
		if (ventity.connection && !IsValid(ventity.connection.socket)) {
			ventity.connection = null as any as VConnection
		}
		if (callbackfn) callbackfn(ventity)
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
function IsConnectableTypes(this: void, ctype1?: string, ctype2?: string) {
	if (ctype1 != null && ctype2 != null) {
		return ctype1 === ctype2
	}
	return true
}
function IsConnectable(this: void, vent1: VEntity, vent2: VEntity) {
	if (vent1.outputPos && vent2.inputPos)
		return IsConnectableTypes(vent1.outputType, vent2.inputType) ? vent1.ent.LocalToWorld(vent1.outputPos).DistToSqr(vent2.ent.LocalToWorld(vent2.inputPos)) < 400 : false
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
		net.WriteTable({ ent: ventity.ent, input: ventity.inputPos, output: ventity.outputPos })
		net.Broadcast()
	}
	export function Connect(this: void, ventity: VEntity | undefined) {
		if (ventity == undefined) {
			print("TR: ventity == null")
			print(debug.traceback())
			return
		}
		const whole = getwhole(ventity)
		ventity = whole[whole.length - 1]
		const vtrailer = GetConnectable(ventity)
		if (vtrailer) {
			PrintTable(vtrailer as VEntity, 0, {})
			const ballsocketent = constraint.AdvBallsocket(ventity.ent, vtrailer.ent, 0, 0, ventity.outputPos as Vector, vtrailer.inputPos as Vector, 0, 0, 0, 0, 0, 360, 360, 360, 0, 0, 0, 0, 0)
			ventity.connection = { ent: vtrailer.ent, socket: ballsocketent }
		} else {
			print("TR: no connectable trailers found :C")
			ventity.ent.EmitSound("tr/nope.wav")
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
			ventity = whole[whole.length - 2] // mafs
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
			print(debug.traceback())
		}
	}
	export function DisconnectEnt(this: void, entity: Entity) {
		valid()
		Trailers.Disconnect(findVEntity(entity))
	}
}

const files = file.Find("tr/systems/*", "LUA")[0]
print("TR: initializing systems")
print("| --- SYSTEMS ---")
for (const system of (files as string[])) {
	print("|- " + system)
	Trailers.systems.push(include("tr/systems/" + system) as any as System)
}
print("| --- SYSTEMS ---")
timer.Remove("TR_system")
timer.Create("TR_system", 0.2, 0, () => {
	valid((ventity) => {
		for (const system of Trailers.systems) {
			if (system.HandleTruck) {
				system.HandleTruck(ventity)
			}
		}
	})
})
list.Set("FLEX", "Trailers", (ent, vtable) => {
	if (istable(vtable)) {
		Trailers.Init({
			ent: ent,
			inputPos: vtable.inputPos,
			outputPos: vtable.outputPos,
			inputType: vtable.inputType,
			outputType: vtable.outputType
		})
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
_G["Trailers"] = Trailers
print("TR: loaded")
export { }
