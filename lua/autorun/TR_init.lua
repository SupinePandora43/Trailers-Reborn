version_MAJOR = 1
version_MINOR = 0
version_PATCH = 1
version_TAG = "beta"
print(
    (((((("Trailers Reborn " .. tostring(version_MAJOR)) .. ".") .. tostring(version_MINOR)) .. ".") .. tostring(version_PATCH)) .. "-") .. tostring(version_TAG)
)
AddCSLuaFile()
if SERVER then
    include("TR/sv_init.lua")
    AddCSLuaFile("TR/cl_init.lua")
    include("TR/sh_deprecated.lua")
else
    include("TR/cl_init.lua")
end
