-- Lua Library inline imports
function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

local ____exports = {}
net.Receive(
    "trailers_reborn_debug_spheres",
    function()
        local ventity = net.ReadTable()
        if ventity.input then
            ventity.ent.inputPOS = ventity.input
            timer.Simple(
                1,
                function()
                    ventity.ent.inputPOS = ventity.input
                end
            )
        end
        if ventity.output then
            ventity.ent.outputPOS = ventity.output
            timer.Simple(
                1,
                function()
                    ventity.ent.outputPOS = ventity.output
                end
            )
        end
    end
)
local enableSpheres = CreateConVar("trailers_spheres", "0", FCVAR_ARCHIVE, "render spheres?", 0, 1)
local function InitSpheres()
    hook.Remove("PostDrawTranslucentRenderables", "simfphys_trailers_reborn")
    if enableSpheres:GetBool() then
        hook.Add(
            "PostDrawTranslucentRenderables",
            "simfphys_trailers_reborn",
            function()
                render.SetColorMaterial()
                __TS__ArrayForEach(
                    ents.FindByClass("gmod_sent_vehicle_fphysics_base"),
                    function(____, entity)
                        if entity.inputPOS then
                            render.DrawSphere(
                                entity:LocalToWorld(entity.inputPOS),
                                10,
                                10,
                                10,
                                Color(255, 0, 0, 100)
                            )
                        end
                        if entity.outputPOS then
                            render.DrawSphere(
                                entity:LocalToWorld(entity.outputPOS),
                                10,
                                10,
                                10,
                                Color(0, 175, 175, 100)
                            )
                        end
                    end
                )
            end
        )
    end
    print("TR: spheres renderer initializated")
end
InitSpheres()
concommand.Add("trailers_reload_CL", InitSpheres, nil, "reloads client side of TR")
list.Set(
    "FLEX_UI",
    "TR_UI",
    function(layout)
        local row = vgui.Create("DTileLayout")
        row:SetBackgroundColor(
            Color(0, 255, 255, 255)
        )
        local connnectBTN = vgui.Create("DButton", row)
        connnectBTN:SetSize(100, 50)
        connnectBTN:SetText("Connect")
        connnectBTN.DoClick = function()
            RunConsoleCommand("trailers_connect")
        end
        local disconnectBTN = vgui.Create("DButton", row)
        disconnectBTN:SetSize(100, 50)
        disconnectBTN:SetText("Disconnect")
        disconnectBTN.DoClick = function()
            RunConsoleCommand("trailers_disconnect")
        end
        layout:Add(row)
    end
)
local disconnectKey = CreateClientConVar(
    "trailers_disconnect_key",
    tostring(KEY_PAD_MINUS),
    true,
    true,
    "disconnect key, used by DBinder"
)
local connectKey = CreateClientConVar(
    "trailers_connect_key",
    tostring(KEY_PAD_PLUS),
    true,
    true,
    "connect key, used by DBinder"
)
local function buildthemenu(self, pnl)
    local y = 20
    local Background = vgui.Create("DShape", pnl.PropPanel)
    Background:SetType("Rect")
    Background:SetPos(20, y)
    Background:SetColor(
        Color(0, 0, 0, 200)
    )
    Background:SetSize(350, 100)
    y = y + 5
    local spheresCheckbox = vgui.Create("DCheckBoxLabel", pnl.PropPanel)
    spheresCheckbox:SetPos(25, y)
    spheresCheckbox:SetText("draw Spheres")
    spheresCheckbox.OnChange = function()
        InitSpheres()
    end
    spheresCheckbox:SetConVar("trailers_spheres")
    spheresCheckbox:SizeToContents()
    y = y + 20
    local connectBinder = vgui.Create("DBinder", pnl.PropPanel)
    connectBinder.OnChange = function(____, butt)
        connectKey:SetInt(butt)
    end
    connectBinder:SetPos(25, y)
    connectBinder:SetText(
        input.GetKeyName(
            connectKey:GetInt()
        )
    )
    local connectBinderTip = vgui.Create("DLabel", pnl.PropPanel)
    connectBinderTip:SetText("Connect button")
    connectBinderTip:SetPos(100, y + 5)
    connectBinderTip:SizeToContents()
    y = y + 40
    local disconnectBinder = vgui.Create("DBinder", pnl.PropPanel)
    disconnectBinder:SetPos(25, y)
    disconnectBinder.OnChange = function(____, butt)
        disconnectKey:SetInt(butt)
    end
    disconnectBinder:SetText(
        input.GetKeyName(
            disconnectKey:GetInt()
        )
    )
    local disconnectBinderTip = vgui.Create("DLabel", pnl.PropPanel)
    disconnectBinderTip:SetText("Disconnect button")
    disconnectBinderTip:SetPos(100, y + 5)
    disconnectBinderTip:SizeToContents()
    if LocalPlayer():IsSuperAdmin() then
        y = y + 50
        local Background1 = vgui.Create("DShape", pnl.PropPanel)
        Background1:SetType("Rect")
        Background1:SetPos(20, y + 15)
        Background1:SetColor(
            Color(0, 0, 0, 200)
        )
        Background1:SetSize(350, 125)
        local Label = vgui.Create("DLabel", pnl.PropPanel)
        Label:SetPos(30, y - 10)
        Label:SetText("Admin-Only Settings!")
        Label:SizeToContents()
        y = y + 25
        local autoconnectCheckbox = vgui.Create("DCheckBoxLabel", pnl.PropPanel)
        autoconnectCheckbox:SetPos(25, y)
        autoconnectCheckbox:SetText("Autoconnect")
        autoconnectCheckbox.OnChange = function()
            RunConsoleCommand("trailers_reload_SV_systemtimer")
        end
        autoconnectCheckbox:SetConVar("trailers_autoconnect")
        autoconnectCheckbox:SizeToContents()
        autoconnectCheckbox:SetTooltip("Automatically connects trailer to truck")
        y = y + 25
        local hydrahelpCheckbox = vgui.Create("DCheckBoxLabel", pnl.PropPanel)
        hydrahelpCheckbox:SetPos(25, y)
        hydrahelpCheckbox:SetText("Hydraulic connectoin")
        hydrahelpCheckbox.OnChange = function()
            RunConsoleCommand("trailers_reload_SV_systemtimer")
        end
        hydrahelpCheckbox:SetConVar("trailers_hydrahelp")
        hydrahelpCheckbox:SizeToContents()
        hydrahelpCheckbox:SetTooltip("Add some hydraulics to help\n!BUGGY!")
        y = y + 25
        local DamageMul = vgui.Create("DNumSlider", pnl.PropPanel)
        DamageMul:SetPos(30, y)
        DamageMul:SetSize(345, 30)
        DamageMul:SetText("Autoconnect distance")
        DamageMul:SetTooltip("uses DistToSqr")
        DamageMul:SetMin(0)
        DamageMul:SetMax(1000)
        DamageMul:SetDecimals(0)
        DamageMul:SetConVar("trailers_autoconnect_distance")
        DamageMul.OnValueChanged = function()
            RunConsoleCommand("trailers_reload_SV_systemtimer")
        end
        y = y + 40
        local EnableConnectSound = vgui.Create("DCheckBoxLabel", pnl.PropPanel)
        EnableConnectSound:SetPos(25, y)
        EnableConnectSound:SetText("Enable connection sound")
        EnableConnectSound:SetConVar("trailers_connectsound")
        EnableConnectSound:SizeToContents()
        EnableConnectSound:SetTooltip("if you have no vcmod CONTENT you'll hear noisy crowbar sounds, this can disable it")
    end
end
hook.Add(
    "SimfphysPopulateVehicles",
    "TR_config",
    function(pc, t, n)
        local node = t:AddNode("Trailers Reborn", "icon16/wrench_orange.png")
        node.DoPopulate = function(self)
            if self.PropPanel then
                return
            end
            self.PropPanel = vgui.Create("ContentContainer", pc)
            self.PropPanel:SetVisible(false)
            self.PropPanel:SetTriggerSpawnlistChange(false)
            buildthemenu(nil, self)
        end
        node.DoClick = function(self)
            self:DoPopulate()
            pc:SwitchPanel(self.PropPanel)
        end
    end
)
return ____exports
