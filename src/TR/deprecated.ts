AddCSLuaFile()
const EntityMeta = FindMetaTable("Entity") as any
EntityMeta.SimfIsTrailer = function (this: Entity) {
	ErrorNoHalt("TR: this vehicle uses old api")
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
	this.SetNWBool("simf_istrailer", bool)
}
EntityMeta.SetCenterposition = function (this: Entity, vector: Vector) {
	this.SetNWVector("simf_centerpos", vector)
}
EntityMeta.SetTrailerCenterposition = function (this: Entity, vector: Vector) {
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
