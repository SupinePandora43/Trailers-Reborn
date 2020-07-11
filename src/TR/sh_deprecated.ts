const Queue = {} as table
declare namespace Trailers {
	function Init(this: void, ventity: VEntity): void
}
const EntityMeta = FindMetaTable("Entity") as any
EntityMeta.SimfIsTrailer = function (this: Entity) {
	print("TR: this vehicle uses old api")
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
EntityMeta.SetSimfIsTrailer = function (this: Entity, bool: boolean) {
	ErrorNoHalt("TR: this vehicle uses old api")
	Queue[this as any] = {}
	timer.Simple(0.25, () => { // now i know why arrow functions exists :D
		if (IsValid(this)) {
			Trailers.Init({ ent: this, input: Queue[this as any].trailerCenterposition, output: Queue[this as any].centerposition })
			Queue[this as any] = null
		}
	})
	this.SetNWBool("simf_istrailer", bool)
}
EntityMeta.SetCenterposition = function (this: Entity, vector: Vector) {
	Queue[this as any].centerposition = vector
	this.SetNWVector("simf_centerpos", vector)
}
EntityMeta.SetTrailerCenterposition = function (this: Entity, vector: Vector) {
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
