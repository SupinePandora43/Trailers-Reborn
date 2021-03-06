declare const _G: any
declare type VConnection = {
	/** trailer Entity */
	ent: Entity
	/** AdvBallSocket  */
	socket: Entity
}
/** @todo */
type ExtensionData = {

}

/** Storage for handling car info */
declare type VEntity = {
	/** inputPos of vehicle */
	inputPos?: Vector
	/** outputPos of vehicle */
	outputPos?: Vector
	/** inputType of vehicle */
	inputType?: string
	/** outputType of vehicle */
	outputType?: string
	/** disable use on trailer? */
	disableUse?: boolean
	/** disable use on wheels only? */
	disableUseOnWheels?: boolean

	/** entity */
	ent: Entity
	/** connection */
	connection?: VConnection
	/** @deprecated */
	phys?: PhysObj
	/** @deprecated */
	hydraulic?: Entity
	/** fix for autodisconnect */
	lastDisconnected?: number
	/** @todo */
	extensions?: ExtensionData[]
};
declare type System = {
	/** you will use this */
	HandleTruck?: (this: void, ventity: VEntity) => void
	/** and probably this */
	Disconnect?: (this: void, ventity: VEntity) => void
	/** pls use this */
	Connect?: (this: void, ventity: VEntity, vtrailer: VEntity) => void
}
/** why i should write it by myself? */
declare namespace table {
	export function insert<T>(this: void, tbl: T[], T)
}
declare namespace constraint {
	export function Hydraulic(this: void, pl: Player | undefined | null, Ent1: Entity, Ent2: Entity, Bone1: number, Bone2: number, LPos1: Vector, LPos2: Vector, Length1: number, Length2: number, width: number, key: KEY, fixed: number, speed: number, material: string, toggle: boolean): [Entity, Entity, Entity, Entity]
}
declare namespace net {
	function Start(this: void, name: string, unrealiable?: boolean)
}
