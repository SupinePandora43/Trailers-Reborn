local function DriverEntered() end
local function DriverLeaved() end

net.Receive("trailers_reborn_ply_vehicle", function()
    local driver = net.ReadBool()
    if driver then
        DriverEntered()
    else
        DriverLeaved()
    end
end)
concommand.Add("trailer_reborn_connect", function(ply, _, _,arg)
	local num = tonumber(arg)
	if num and num <128 and num >0 then
		net.Start("trailers_reborn_connect")
		net.WriteInt(num,8) -- 254 trailers max
		net.SendToServer()
	end

end)
list.Set("DesktopWindows", "Connect Traier", {
    title = "Context Menu Icon",
    icon = "icon64/icon.png",
    init = function(icon, window)
        print(1)
        -- net.Start("simf_trail_connect")
        -- net.SendToServer()
        window:Remove()
    end
})
