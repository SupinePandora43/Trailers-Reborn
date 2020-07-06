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

list.Set("DesktopWindows", "Connect Traier", {
	title: "Context Menu Icon",
	icon: "icon64/icon.png",
	init: (icon, window) => {
		print(icon)
		//net.Start("simf_trail_connect")
		//net.SendToServer()
		window.Remove()
	}
})
