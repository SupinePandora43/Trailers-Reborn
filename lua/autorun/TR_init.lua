AddCSLuaFile()
if SERVER then
    include("TR/sv_init.lua")
    AddCSLuaFile("TR/cl_init.lua")
    include("TR/sh_deprecated.lua")
elseif CLIENT then
    include("TR/cl_init.lua")
end
