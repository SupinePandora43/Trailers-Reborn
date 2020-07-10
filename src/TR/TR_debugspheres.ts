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
	connnectBTN.SetSize(100,50)
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
