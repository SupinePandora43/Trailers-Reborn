const Queue = {} as table
declare namespace Trailers {
	function Init(this: void, ventity: VEntity): void
}
const EntityMeta = FindMetaTable("Entity") as any
EntityMeta.SimfIsTrailer = function (this: Entity) {
	return this.GetNWBool("simf_istrailer", false)
}
EntityMeta.GetCenterposition = function (this: Entity) {
	return this.GetNWVector("simf_centerpos", Vector(0, -100, 0))
}
EntityMeta.GetTrailerCenterposition = function (this: Entity) {
	return this.GetNWVector("simf_trailercenterpos", Vector(0, 0, 0))
}
EntityMeta.TrailerCanConnect = function (this: Entity) {
	return this.GetNWVector("simf_trailercancon", false)
}
EntityMeta.CarCanConnect = function (this: Entity) {
	return this.GetNWVector("simf_carcancon", false)
}
EntityMeta.GetLeftSignalEnabled = function (this: Entity) {
	return this.GetNWVector("simfs_leftsig", false)
}
EntityMeta.GetRightSignalEnabled = function (this: Entity) {
	return this.GetNWVector("simfs_rightsig", false)
}
EntityMeta.VehicleGetCanConnect = function (this: Entity) {
	return this.GetNWBool("simfs_veh_canconnect", false)
}
function StartQueueIfNotExists(this: void, ent: Entity) {
	Queue[ent as any] = Queue[ent as any] || {}
	timer.Simple(1, () => { // now i know why arrow functions exists :D
		if (IsValid(ent)) {
			if (Queue[ent as any] != null) {
				MsgC(Color(255, 255, 0), "TR: this vehicle uses old api\n")
				Trailers.Init({ ent: ent, inputPos: Queue[ent as any].trailerCenterposition, outputPos: Queue[ent as any].centerposition })
				Queue[ent as any] = null
			}
		}
	})
}
EntityMeta.SetSimfIsTrailer = function (this: Entity, bool: boolean) {
	ErrorNoHalt("TR: this vehicle uses old api")
	StartQueueIfNotExists(this)
	this.SetNWBool("simf_istrailer", bool)
}
EntityMeta.SetCenterposition = function (this: Entity, vector: Vector) {
	StartQueueIfNotExists(this)
	Queue[this as any].centerposition = vector
	this.SetNWVector("simf_centerpos", vector)
}
EntityMeta.SetTrailerCenterposition = function (this: Entity, vector: Vector) {
	StartQueueIfNotExists(this)
	Queue[this as any].trailerCenterposition = vector
	this.SetNWVector("simf_trailercenterpos", vector)
}
EntityMeta.SetTrailerCanConnect = function (this: Entity, bool: boolean) {
	this.SetNWBool("simf_trailercancon", bool)
}
EntityMeta.SetCarCanConnect = function (this: Entity, bool: boolean) {
	this.SetNWBool("simf_carcancon", bool)
}
EntityMeta.SetLeftSignalEnabled = function (this: Entity, bool: boolean) {
	this.SetNWBool("simfs_leftsig", bool)
}
EntityMeta.SetRightSignalEnabled = function (this: Entity, bool: boolean) {
	this.SetNWBool("simfs_rightsig", bool)
}
EntityMeta.VehicleSetCanConnect = function (this: Entity, bool: boolean) {
	this.SetNWBool("simfs_veh_canconnect", bool)
}
export = null
