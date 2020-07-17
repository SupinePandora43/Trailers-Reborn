import sh_deprecated = require("./sh_deprecated")

net.Receive("trailers_reborn_debug_spheres", () => {
	const ventity = net.ReadTable()
	if (ventity.input) {
		ventity.ent.inputPOS = ventity.input
		timer.Simple(1, () => {
			ventity.ent.inputPOS = ventity.input
		})
	}
	if (ventity.output) {
		ventity.ent.outputPOS = ventity.output
		timer.Simple(1, () => {
			ventity.ent.outputPOS = ventity.output
		})
	}
})
const enum SIZEs {
	SIZE = 10,
	STEPS = 10
}
const enableSpheres = CreateConVar("trailers_spheres", "0", FCVAR.FCVAR_ARCHIVE, "render spheres?", 0, 1)
function InitSpheres(this: void) {
	hook.Remove("PostDrawTranslucentRenderables", "simfphys_trailers_reborn")
	if (enableSpheres.GetBool()) {
		hook.Add("PostDrawTranslucentRenderables", "simfphys_trailers_reborn", () => {
			render.SetColorMaterial();
			(ents.FindByClass("gmod_sent_vehicle_fphysics_base") as Entity[]).forEach((entity) => {
				if ((entity as any).inputPOS) {
					render.DrawSphere(((entity as any) as Entity).LocalToWorld((entity as any).inputPOS), SIZEs.SIZE, SIZEs.STEPS, SIZEs.STEPS, Color(255, 0, 0, 100) as Color)
				}
				if ((entity as any).outputPOS) {
					render.DrawSphere(((entity as any) as Entity).LocalToWorld((entity as any).outputPOS), SIZEs.SIZE, SIZEs.STEPS, SIZEs.STEPS, Color(0, 175, 175, 100) as Color)
				}
			})
		})
	}
	print("TR: spheres renderer initializated")
}
InitSpheres()
concommand.Add("trailers_reload_CL", InitSpheres, undefined, "reloads client side of TR")
declare namespace list {
	function Set(this: void, identifier: "FLEX_UI", key: any, item: (this: void, layout: DListLayout) => void): void
}
declare namespace vgui {
	function Create(this: void, classname: string, parent?: DPanel, name?: string): Panel
}
list.Set("FLEX_UI", "TR_UI", (layout: DListLayout) => {
	const row = vgui.Create("DTileLayout") as DTileLayout
	row.SetBackgroundColor(Color(0, 255, 255, 255) as Color)
	const connnectBTN = vgui.Create("DButton", row) as DButton
	connnectBTN.SetSize(100, 50)
	connnectBTN.SetText("Connect")
	connnectBTN.DoClick = () => {
		RunConsoleCommand("trailers_connect")
	}
	const disconnectBTN = vgui.Create("DButton", row) as DButton
	disconnectBTN.SetSize(100, 50)
	disconnectBTN.SetText("Disconnect")
	disconnectBTN.DoClick = () => {
		RunConsoleCommand("trailers_disconnect")
	}
	layout.Add(row)
})

function buildthemenu(pnl: Panel | any) {
	const Background = vgui.Create('DShape', pnl.PropPanel) as DShape
	Background.SetType('Rect')
	Background.SetPos(20, 20)
	Background.SetColor(Color(0, 0, 0, 200))
	Background.SetSize(350, 25)

	const spheresCheckbox = vgui.Create("DCheckBoxLabel", pnl.PropPanel) as DCheckBoxLabel
	spheresCheckbox.SetPos(25, 25)
	spheresCheckbox.SetText("draw Spheres")
	spheresCheckbox.OnChange = () => {
		InitSpheres()
	}
	spheresCheckbox.SetConVar("trailers_spheres")
	spheresCheckbox.SizeToContents()
	if (LocalPlayer().IsSuperAdmin()) {
		const Background1 = vgui.Create('DShape', pnl.PropPanel) as DShape
		Background1.SetType('Rect')
		Background1.SetPos(20, 50 + 20)
		Background1.SetColor(Color(0, 0, 0, 200))
		Background1.SetSize(350, 125)

		const Label = vgui.Create('DLabel', pnl.PropPanel)
		Label.SetPos(30, 50)
		Label.SetText("Admin-Only Settings!")
		Label.SizeToContents()

		const autoconnectCheckbox = vgui.Create("DCheckBoxLabel", pnl.PropPanel) as DCheckBoxLabel
		autoconnectCheckbox.SetPos(25, 75)
		autoconnectCheckbox.SetText("Autoconnect")
		autoconnectCheckbox.OnChange = () => {
			RunConsoleCommand("trailers_reload_SV_systemtimer")
		}
		autoconnectCheckbox.SetConVar("trailers_autoconnect")
		autoconnectCheckbox.SizeToContents()
		autoconnectCheckbox.SetTooltip("Automatically connects trailer to truck")

		const hydrahelpCheckbox = vgui.Create("DCheckBoxLabel", pnl.PropPanel) as DCheckBoxLabel
		hydrahelpCheckbox.SetPos(25, 100)
		hydrahelpCheckbox.SetText("Hydraulic connectoin")
		hydrahelpCheckbox.OnChange = () => {
			RunConsoleCommand("trailers_reload_SV_systemtimer")
		}
		hydrahelpCheckbox.SetConVar("trailers_hydrahelp")
		hydrahelpCheckbox.SizeToContents()
		hydrahelpCheckbox.SetTooltip("Add some hydraulics to help\n!BUGGY!")

		const DamageMul = vgui.Create("DNumSlider", pnl.PropPanel) as DNumSlider
		DamageMul.SetPos(30, 125)
		DamageMul.SetSize(345, 30)
		DamageMul.SetText("Autoconnect distance")
		DamageMul.SetTooltip("uses DistToSqr")
		DamageMul.SetMin(0)
		DamageMul.SetMax(1000)
		DamageMul.SetDecimals(0)
		DamageMul.SetConVar("trailers_autoconnect_distance")
		DamageMul.OnValueChanged = () => {
			RunConsoleCommand("trailers_reload_SV_systemtimer")
		}

		const EnableConnectSound = vgui.Create("DCheckBoxLabel", pnl.PropPanel) as DCheckBoxLabel
		EnableConnectSound.SetPos(25, 170)
		EnableConnectSound.SetText("Enable connection sound")
		EnableConnectSound.SetConVar("trailers_connectsound")
		EnableConnectSound.SizeToContents()
		EnableConnectSound.SetTooltip("if you have no vcmod CONTENT you'll hear noisy crowbar sounds, this can disable it")
	}
}
hook.Add("SimfphysPopulateVehicles", "TR_config", (pc, t, n) => {
	const node = t.AddNode('Trailers Reborn', 'icon16/wrench_orange.png')
	node.DoPopulate = function (this) {
		if (this.PropPanel) return
		this.PropPanel = vgui.Create('ContentContainer', pc)
		this.PropPanel.SetVisible(false)
		this.PropPanel.SetTriggerSpawnlistChange(false)
		buildthemenu(this)
	}
	node.DoClick = function (this) {
		this.DoPopulate()
		pc.SwitchPanel(this.PropPanel)
	}
})
