AddCSLuaFile()
if (SERVER) {
	include("TR/sv_init.lua")
	AddCSLuaFile("TR/cl_init.lua")
	include("TR/sh_deprecated.lua")
} else if (CLIENT) {
	include("TR/cl_init.lua")
}
