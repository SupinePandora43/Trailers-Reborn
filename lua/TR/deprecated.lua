AddCSLuaFile()
EntityMeta = FindMetaTable("Entity")
EntityMeta.SimfIsTrailer = function(self)
    ErrorNoHalt("TR: this vehicle uses old api")
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
EntityMeta.SetSimfIsTrailer = function(self, bool)
    ErrorNoHalt("TR: this vehicle uses old api")
    self:SetNWBool("simf_istrailer", bool)
end
EntityMeta.SetCenterposition = function(self, vector)
    self:SetNWVector("simf_centerpos", vector)
end
EntityMeta.SetTrailerCenterposition = function(self, vector)
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
