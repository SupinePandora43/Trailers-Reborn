AddCSLuaFile()
if (SERVER) {
	include("TR/simfphys_trailers_reborn.lua")
	AddCSLuaFile("TR/TR_debugspheres.lua")
} else if (CLIENT) {
	include("TR/TR_debugspheres.lua")
}
include("TR/deprecated.lua")
