declare const _G: any
declare type VConnection = {
	ent: Entity
	socket: Entity
}
/** Storage for handling car info */
declare type VEntity = {
	ent: Entity
	input?: Vector
	output?: Vector
	connection?: VConnection
};
declare type System = {
	HandleTruck?: (this: void, ventity: VEntity) => void
	Disconnect?: (this: void, ventity: VEntity) => void
}
declare namespace table {
	
	export function insert<T>(this: void, tbl:T[],T)
}
/** why i should write it by myself? */
declare namespace net {
	function Start(this: void, name: string, unrealiable?: boolean)
}
