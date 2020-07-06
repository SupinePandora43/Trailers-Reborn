declare type VConnection = {
	ent: Entity
	socket: Entity
}
/** Storage for handling car info */
declare type VEntity = {
	ent: Entity
	input: Vector
	output: Vector
	connection: VConnection
};
declare type System = {
	HandleTruck: (this: void, ventity: VEntity) => void
}
/** why i should write it by myself? */
declare namespace net {
	function Start(this: void, name: string, unrealiable?: boolean)
}
