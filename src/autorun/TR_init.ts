AddCSLuaFile() // wiki says this not needed, but wiki lies!
if (SERVER) {
	AddCSLuaFile("TR/cl_init.lua")
	include("TR/sv_init.lua")
	AddCSLuaFile("TR/sh_deprecated.lua")
	include("TR/sh_deprecated.lua")
} else {
	include("TR/cl_init.lua")
	include("TR/sh_deprecated.lua")
}
