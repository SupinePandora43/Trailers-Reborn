local defaultvehicles = {
    ["models/props_vehicles/apc001.mdl"] = {
        outputPos = Vector(0, -133.6, -27),
        outputType = "ballsocket"
    },
    ["models/combine_apc.mdl"] = {
        outputPos = Vector(0, -129.7, 38.1),
        outputType = "ballsocket"
    },
    ["models/buggy.mdl"] = {
        outputPos = Vector(0, -109.4, 18.2),
        outputType = "ballsocket"
    },
    ["models/vehicle.mdl"] = {
        outputPos = Vector(0, -142.9, 40),
        outputType = "ballsocket"
    },
    ["models/vehicles/buggy_elite.mdl"] = {
        outputPos = Vector(0, -109.9, 18.2),
        outputType = "ballsocket"
    },
    ["models/vehicles/7seatvan.mdl"] = {
        outputPos = Vector(0, -107.7, 25.2),
        outputType = "ballsocket"
    },
    ["models/blu/gaz52/gaz52.mdl"] = {
        outputPos = Vector(0.021, -174.78, 30.383),
        outputType = "ballsocket"
    },
    ["models/blu/hatchback/pw_hatchback.mdl"] = {
        outputPos = Vector(-76.652, -0.001, 18.004),
        outputType = "ballsocket"
    },
    ["models/blu/skoda_liaz/skoda_liaz.mdl"] = {
        outputPos = Vector(0.002, -44.919, 45.268),
        outputType = "axis"
    },
    ["models/blu/moskvich/moskvich.mdl"] = {
        outputPos = Vector(-102.828, 0.007, 18.315),
        outputType = "ballsocket"
    },
    ["models/blu/trabant/trabant.mdl"] = {
        outputPos = Vector(0.003, -77.714, 13.46),
        outputType = "ballsocket"
    },
    ["models/blu/trabant/trabant02.mdl"] = {
        outputPos = Vector(0.003, -77.714, 13.46),
        outputType = "ballsocket"
    },
    ["models/blu/van/pw_van.mdl"] = {
        outputPos = Vector(-118.248, -0.248, 24.671),
        outputType = "ballsocket"
    },
    ["models/blu/volga/volga.mdl"] = {
        outputPos = Vector(-103.918, 0.002, 23.304),
        outputType = "ballsocket"
    },
    ["models/blu/avia/avia.mdl"] = {
        outputPos = Vector(-109.309, -0.003, 20.217),
        outputType = "ballsocket"
    },
    ["models/blu/zaz/zaz.mdl"] = {
        outputPos = Vector(-95.402, 0, 20.387),
        outputType = "ballsocket"
    },
    ["models/blu/gtav/dukes/dukes.mdl"] = {
        outputPos = Vector(-124.247, 0, 0),
        outputType = "ballsocket"
    }
}

hook.Add("OnEntityCreated", "TR_default_vehicles", function(ent)
    if ent:GetClass() == "gmod_sent_vehicle_fphysics_base" then
        timer.Simple(1, function()
            if not IsValid(ent) then return end
            local entModel = ent:GetModel()
            if defaultvehicles[entModel] then
                Trailers.Init({
                    ent = ent,
                    outputPos = defaultvehicles[entModel].outputPos,
                    outputType = defaultvehicles[entModel].outputType
                })
            end
            -- if ent:GetModel() == "models/props_vehicles/apc001.mdl" then ent:SetCenterposition(Vector(0,-133.6,-27)) end
            -- if ent:GetModel() == "models/combine_apc.mdl" then ent:SetCenterposition(Vector(0,-129.7,38.1)) end
            -- if ent:GetModel() == "models/buggy.mdl" then ent:SetCenterposition(Vector(0,-109.4,18.2)) end
            -- if ent:GetModel() == "models/vehicle.mdl" then ent:SetCenterposition(Vector(0,-142.9,40)) end
            -- if ent:GetModel() == "models/vehicles/buggy_elite.mdl" then ent:SetCenterposition(Vector(0,-109.9,18.2)) end
            -- if ent:GetModel() == "models/vehicles/7seatvan.mdl" then ent:SetCenterposition(Vector(0,-107.7,25.2)) end
            -- if ent:GetModel() == "models/blu/gaz52/gaz52.mdl" then ent:SetCenterposition(Vector(0.021,-174.78,30.383)) end
            -- if ent:GetModel() == "models/blu/hatchback/pw_hatchback.mdl" then ent:SetCenterposition(Vector(-76.652,-0.001,18.004)) end
            -- if ent:GetModel() == "models/blu/skoda_liaz/skoda_liaz.mdl" then ent:SetCenterposition(Vector(0.002,-44.919,45.268)) end
            -- if ent:GetModel() == "models/blu/moskvich/moskvich.mdl" then ent:SetCenterposition(Vector(-102.828,0.007,18.315)) end
            -- if ent:GetModel() == "models/blu/trabant/trabant.mdl" then ent:SetCenterposition(Vector(0.003,-77.714,13.46)) end
            -- if ent:GetModel() == "models/blu/trabant/trabant02.mdl" then ent:SetCenterposition(Vector(0.003,-77.714,13.46)) end
            -- if ent:GetModel() == "models/blu/van/pw_van.mdl" then ent:SetCenterposition(Vector(-118.248,-0.248,24.671)) end
            -- if ent:GetModel() == "models/blu/volga/volga.mdl" then ent:SetCenterposition(Vector(-103.918,0.002,23.304)) end
            -- if ent:GetModel() == "models/blu/avia/avia.mdl" then ent:SetCenterposition(Vector(-109.309,-0.003,20.217)) end
            -- if ent:GetModel() == "models/blu/zaz/zaz.mdl" then ent:SetCenterposition(Vector(-95.402,0,20.387)) end
            -- if ent:GetModel() == "models/blu/gtav/dukes/dukes.mdl" then ent:SetCenterposition(Vector(-124.247,0,0)) end
        end)
    end
end)
