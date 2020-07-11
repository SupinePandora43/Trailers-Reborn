AddCSLuaFile()
if SERVER then
    include("TR/sv_init.lua")
    AddCSLuaFile("TR/cl_init.lua")
elseif CLIENT then
    include("TR/cl_init.lua")
end
AddCSLuaFile("TR/sh_deprecated.lua")
include("TR/sh_deprecated.lua")
