const version_MAJOR = 1
const version_MINOR = 0
const version_PATCH = 1
const version_TAG = "beta"


print("Trailers Reborn " + version_MAJOR + "." + version_MINOR + "." + version_PATCH + "-" + version_TAG)


AddCSLuaFile()
if (SERVER) {
	include("TR/sv_init.lua")
	AddCSLuaFile("TR/cl_init.lua")
	include("TR/sh_deprecated.lua")
} else {
	include("TR/cl_init.lua")
}
