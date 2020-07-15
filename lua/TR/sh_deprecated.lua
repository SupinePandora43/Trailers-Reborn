local Queue = {}
local EntityMeta = FindMetaTable("Entity")
EntityMeta.SimfIsTrailer = function(self)
    return self:GetNWBool("simf_istrailer", false)
end
EntityMeta.GetCenterposition = function(self)
    return self:GetNWVector(
        "simf_centerpos",
        Vector(0, -100, 0)
    )
end
EntityMeta.GetTrailerCenterposition = function(self)
    return self:GetNWVector(
        "simf_trailercenterpos",
        Vector(0, 0, 0)
    )
end
EntityMeta.TrailerCanConnect = function(self)
    return self:GetNWVector("simf_trailercancon", false)
end
EntityMeta.CarCanConnect = function(self)
    return self:GetNWVector("simf_carcancon", false)
end
EntityMeta.GetLeftSignalEnabled = function(self)
    return self:GetNWVector("simfs_leftsig", false)
end
EntityMeta.GetRightSignalEnabled = function(self)
    return self:GetNWVector("simfs_rightsig", false)
end
EntityMeta.VehicleGetCanConnect = function(self)
    return self:GetNWBool("simfs_veh_canconnect", false)
end
local function StartQueueIfNotExists(ent)
    Queue[ent] = Queue[ent] or ({})
    timer.Simple(
        1,
        function()
            if IsValid(ent) then
                if Queue[ent] ~= nil then
                    MsgC(
                        Color(255, 255, 0),
                        "TR: this vehicle uses old api\n"
                    )
                    Trailers.Init({ent = ent, inputPos = Queue[ent].trailerCenterposition, outputPos = Queue[ent].centerposition})
                    Queue[ent] = nil
                end
            end
        end
    )
end
EntityMeta.SetSimfIsTrailer = function(self, bool)
    ErrorNoHalt("TR: this vehicle uses old api")
    StartQueueIfNotExists(self)
    self:SetNWBool("simf_istrailer", bool)
end
EntityMeta.SetCenterposition = function(self, vector)
    StartQueueIfNotExists(self)
    Queue[self].centerposition = vector
    self:SetNWVector("simf_centerpos", vector)
end
EntityMeta.SetTrailerCenterposition = function(self, vector)
    StartQueueIfNotExists(self)
    Queue[self].trailerCenterposition = vector
    self:SetNWVector("simf_trailercenterpos", vector)
end
EntityMeta.SetTrailerCanConnect = function(self, bool)
    self:SetNWBool("simf_trailercancon", bool)
end
EntityMeta.SetCarCanConnect = function(self, bool)
    self:SetNWBool("simf_carcancon", bool)
end
EntityMeta.SetLeftSignalEnabled = function(self, bool)
    self:SetNWBool("simfs_leftsig", bool)
end
EntityMeta.SetRightSignalEnabled = function(self, bool)
    self:SetNWBool("simfs_rightsig", bool)
end
EntityMeta.VehicleSetCanConnect = function(self, bool)
    self:SetNWBool("simfs_veh_canconnect", bool)
end
local ____exports = nil
return ____exports
