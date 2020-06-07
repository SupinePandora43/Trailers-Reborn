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
net.Receive("trailers_reborn_debug_spheres", function()
	local ent = net.ReadEntity()
	local isinput=net.ReadBool()
	local inppos,outpos
	if isinput then
		inppos = net.ReadVector()
		ent.inputPos=inppos
	end
	local isout=net.ReadBool()
	if isout then
		outpos = net.ReadVector()
		ent.outputPos=outpos
	end
	timer.Simple(3, function() ent.inputPos=inppos ent.outputPos=outpos end)
end)
hook.Add("PostDrawTranslucentRenderables", "trailers_reborn", function()
	for _, ent in pairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
		if ent.inputPos then
			render.SetColorMaterialIgnoreZ()
			render.DrawSphere(ent:LocalToWorld(ent.inputPos), 30, 30, 30, Color(255, 0, 0, 100))
		end
		if ent.outputPos then
			render.SetColorMaterialIgnoreZ()
			render.DrawSphere(ent:LocalToWorld(ent.outputPos), 30, 30, 30, Color(0, 175, 175, 100))
		end
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
