AddCSLuaFile()
if (SERVER) {
	include("TR/sv_init.lua")
	AddCSLuaFile("TR/cl_init.lua")
} else if (CLIENT) {
	include("TR/cl_init.lua")
}
AddCSLuaFile("TR/sh_deprecated.lua")
include("TR/sh_deprecated.lua")
