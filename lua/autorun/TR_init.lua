AddCSLuaFile()
if SERVER then
    include("TR/simfphys_trailers_reborn.lua")
    AddCSLuaFile("TR/TR_debugspheres.lua")
elseif CLIENT then
    include("TR/TR_debugspheres.lua")
end
include("TR/deprecated.lua")
