// idk why i do this lol
declare namespace surface {
	function SetDrawColor(this: void, col: IColor | Color): void
	function SetDrawColor(this: void, r: number, g: number, b: number, a?: number): void
	function DrawPoly(this: void, vertices: PolygonVertex | table): void
	function DrawRect(this: void, x: number, y: number, width: number, height: number): void
	function DrawOutlinedRect(this: void, x: number, y: number, width: number, height: number): void
	function SetMaterial(this: void, mat: IMaterial | Material): void
	function DrawTexturedRect(this: void, x: number, y: number, width: number, height: number): void
	function DrawTexturedRectUV(this: void, ...test: any[]): void
	function GetTextSize(this: void, name: string): [number, number]
	function SetFont(this: void, name: string): void
}
/*
declare namespace math {
	export function Round(this: void, value: number, decimals?: number): number
	function cos(this: void, value: number): number
	function rad(this: void, value: number): number
	function sin(this: void, value: number): number
}*/
/*
declare type PolygonVertex = {
	y: number
	x: number
}*/
const blur = Material("pp/blurscreen")[0]
const gradLeft = Material("vgui/gradient-l")[0]
const gradUp = Material("vgui/gradient-u")[0]
const gradRight = Material("vgui/gradient-r")[0]
const gradDown = Material("vgui/gradient-d")[0]
const TDLibUtil = {} as any
TDLibUtil.DrawCircle = function (this: void, x: number, y: number, r: number, col: IColor) {
	const circle = []
	for (let i = 1; i < 360; i++) {
		circle[i] = {} as any
		circle[i].x = x + math.cos(math.rad(i * 360) / 360) * r
		circle[i].y = y + math.sin(math.rad(i * 360) / 360) * r
	}
	/* i = 1, 360 do
		
	end*/
	surface.SetDrawColor(col)
	draw.NoTexture()
	surface.DrawPoly(circle)
}
TDLibUtil.DrawArc = function (this: void, x: number, y: number, ang: number, p: number, rad: number, color: IColor, seg?: number) {
	seg = seg || 80
	ang = (-ang) + 180
	const circle: PolygonVertex[] = []
	table.insert(circle, { x: x, y: y })
	for (let i = 0; i < seg; i++) {
		const a = math.rad((i / seg) * -p + ang)
		table.insert(circle, { x: x + math.sin(a) * rad, y: y + math.cos(a) * rad })
	}
	surface.SetDrawColor(color)
	draw.NoTexture()
	surface.DrawPoly(circle)
}
TDLibUtil.LerpColor = function (this: void, frac: number, from: Color, to: Color) {
	return Color(
		Lerp(frac, from.r, to.r),
		Lerp(frac, from.g, to.g),
		Lerp(frac, from.b, to.b),
		Lerp(frac, from.a, to.a)
	)
}
TDLibUtil.HoverFunc = function (this: void, s: Panel) {
	return s.IsHovered()
}
TDLibUtil.HoverFuncChild = function (this: void, s: Panel) { return s.IsHovered() || s.IsChildHovered(false) }
function drawCircle(this: void, x: number, y: number, r: number) {
	const circle: PolygonVertex[] = []
	for (let i = 0; i < 360; i++) {
		circle[i] = {
			x: x + math.cos(math.rad(i * 360) / 360) * r,
			y: y + math.sin(math.rad(i * 360) / 360) * r
		} as PolygonVertex
	}
	surface.DrawPoly(circle)
}
const classes: any = {}
classes.On = function (this: Panel | any, name: string, fn: Function) {
	name = this.AppendOverwrite || name
	const old = this[name]
	this[name] = function (s: Panel, ...items: any[]) {
		if (old) {
			old(s, items)
		}
		fn(s, items)
	}
}
classes.SetupTransition = function (this: Panel | any, name: string, speed: number, fn: Function) {
	fn = this.TransitionFunc || fn
	this[name] = 0
	this.On("Think", function (s: Panel | any) {
		s[name] = Lerp(FrameTime() * speed, s[name], fn(s) && 1 || 0)
	})
}
classes.FadeHover = function (this: Panel | any, col: Color, speed: number, rad: number) {
	col = col || Color(255, 255, 255, 30)
	speed = speed || 6
	this.SetupTransition("FadeHover", speed, TDLibUtil.HoverFunc)
	this.On("Paint", function (this: Panel | any, w: number, h: number) {
		let col1 = ColorAlpha(col, col.a * this.FadeHover)
		if (rad && rad > 0) {
			draw.RoundedBox(rad, 0, 0, w, h, col1 as Color)
		}
		surface.SetDrawColor(col1)
		surface.DrawRect(0, 0, w, h)
	})
}
classes.BarHover = function (this: Panel | any, col?: Color, height?: number, speed?: number) {
	col = col || Color(255, 255, 255, 255) as Color
	height = height || 2
	speed = speed || 6
	this.SetupTransition("BarHover", speed, TDLibUtil.HoverFunc)
	this.On("PaintOver", function (this: Panel | any, w: number, h: number) {
		const bar = math.Round(w * this.BarHover)
		surface.SetDrawColor(col as Color)
		surface.DrawRect(w / 2 - bar / 2, h - (height as number), bar, (height as number))
	})
}
classes.FillHover = function (this: Panel | any, col: Color, dir?: DOCK, speed?: number, mat?: IMaterial) {
	col = col || Color(255, 255, 255, 30)
	dir = dir || DOCK.LEFT
	speed = speed || 8
	this.SetupTransition("FillHover", speed, TDLibUtil.HoverFunc)
	this.On("PaintOver", function (this: Panel | any, w: number, h: number) {
		surface.SetDrawColor(col)
		//let x, y, fw, fh
		const x = (dir == DOCK.RIGHT) ? math.Round(w * this.FillHover) : 0
		const prog = math.Round(h * this.FillHover)
		const y = (dir == DOCK.BOTTOM) ? h - prog : 0
		const fw = (dir == DOCK.LEFT) ? math.Round(w * this.FillHover) : ((dir == DOCK.RIGHT) ? prog : w)
		const fh = (dir == DOCK.TOP) ? math.Round(h * this.FillHover) : ((dir == DOCK.BOTTOM) ? prog : h)
		/*if (dir == DOCK.LEFT) {
			x, y, fw, fh = 0, 0, math.Round(w * s.FillHover), h
		} else if (dir == DOCK.TOP) {
			x, y, fw, fh = 0, 0, w, math.Round(h * s.FillHover)
		} else if (dir == DOCK.RIGHT) {
			const prog = math.Round(w * s.FillHover)
			x, y, fw, fh = w - prog, 0, prog, h
		} else if (dir == DOCK.BOTTOM) {
			const prog = math.Round(h * s.FillHover)
			x, y, fw, fh = 0, h - prog, w, prog
		}*/
		if (mat) {
			surface.SetMaterial(mat)
			surface.DrawTexturedRect(x, y, fw, fh)
		} else {
			surface.DrawRect(x, y, fw, fh)
		}
	})
}
classes.Background = function (this: Panel | any, col: Color, rad: number, rtl: boolean, rtr: boolean, rbl: boolean, rbr: boolean) {
	this.On("Paint", function (this: Panel | any, w: number, h: number) {
		if (rad && rad > 0) {
			if (rtl != null) {
				draw.RoundedBoxEx(rad, 0, 0, w, h, col, rtl, rtr, rbl, rbr)
			} else {
				draw.RoundedBox(rad, 0, 0, w, h, col)
			}
		} else {
			surface.SetDrawColor(col)
			surface.DrawRect(0, 0, w, h)
		}
	})
}
classes.Material = function (this: Panel | any, mat: Material, col: Color) {
	col = col || Color(255, 255, 255, 255)
	this.On("Paint", function (this: Panel, w: number, h: number) {
		surface.SetDrawColor(col)
		surface.SetMaterial(mat)
		surface.DrawTexturedRect(0, 0, w, h)
	})
}
classes.TiledMaterial = function (this: Panel | any, mat: Material, tw: number, th: number, col: Color) {
	col = col || Color(255, 255, 255, 255)
	this.On("Paint", function (this: Panel, w: number, h: number) {
		surface.SetMaterial(mat)
		surface.SetDrawColor(col)
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / tw, h / th)
	})
}
classes.Outline = function (this: Panel | any, col: Color, width: number) {
	col = col || Color(255, 255, 255, 255)
	width = width || 1
	this.On("Paint", function (this: Panel, w: number, h: number) {
		surface.SetDrawColor(col)
		for (let i = 0; i < width - 1; i++) {
			//for i = 0, width - 1 do
			surface.DrawOutlinedRect(0 + i, 0 + i, w - i * 2, h - i * 2)
		}
	})
}
classes.LinedCorners = function (this: Panel | any, col: Color, len: number) {
	col = col || Color(255, 255, 255, 255)
	len = len || 15
	this.On("Paint", function (this: Panel, w: number, h: number) {
		surface.SetDrawColor(col)
		surface.DrawRect(0, 0, len, 1)
		surface.DrawRect(0, 1, 1, len - 1)
		surface.DrawRect(w - len, h - 1, len, 1)
		surface.DrawRect(w - 1, h - len, 1, len - 1)
	})
}
classes.SideBlock = function (this: Panel | any, col: Color, size: number, side: DOCK) {
	col = col || Color(255, 255, 255, 255)
	size = size || 3
	side = side || DOCK.LEFT
	this.On("Paint", function (this: Panel, w: number, h: number) {
		surface.SetDrawColor(col)
		if (side == DOCK.LEFT) {
			surface.DrawRect(0, 0, size, h)
		} else if (side == DOCK.TOP) {
			surface.DrawRect(0, 0, w, size)
		} else if (side == DOCK.RIGHT) {
			surface.DrawRect(w - size, 0, size, h)
		} else if (side == DOCK.BOTTOM) {
			surface.DrawRect(0, h - size, w, size)
		}
	})
}
classes.Text = function (this: Panel | any, text: string, font: string, col: Color, alignment: TEXT_ALIGN, ox: number, oy: number, paint: never) {
	font = font || "Trebuchet24"
	col = col || Color(255, 255, 255, 255)
	alignment = alignment || TEXT_ALIGN.TEXT_ALIGN_CENTER
	ox = ox || 0
	oy = oy || 0
	if (!paint && this.SetText && this.SetFont && this.SetTextColor) {
		this.SetText(text)
		this.SetFont(font)
		this.SetTextColor(col)
	} else {
		this.On("Paint", function (this: Panel | any, w: number, h: number) {
			let x = 0
			if (alignment == TEXT_ALIGN.TEXT_ALIGN_CENTER) {
				x = w / 2
			} else if (alignment == TEXT_ALIGN.TEXT_ALIGN_RIGHT) {
				x = w
			}
			draw.SimpleText(text, font, x + ox, h / 2 + oy, col, alignment, TEXT_ALIGN.TEXT_ALIGN_CENTER)
		})
	}
}
classes.DualText = function (this: Panel | any, toptext: string, topfont: string, topcol: Color, bottomtext: string, bottomfont: string, bottomcol: Color, alignment: TEXT_ALIGN, centerSpacing: number) {
	topfont = topfont || "Trebuchet24"
	topcol = topcol || Color(0, 127, 255, 255)
	bottomfont = bottomfont || "Trebuchet18"
	bottomcol = bottomcol || Color(255, 255, 255, 255)
	alignment = alignment || TEXT_ALIGN.TEXT_ALIGN_CENTER
	centerSpacing = centerSpacing || 0
	this.On("Paint", function (this: Panel | any, w: number, h: number) {
		surface.SetFont(topfont)
		const textSizes = surface.GetTextSize(toptext)
		const tw = textSizes[0], th = textSizes[1]
		surface.SetFont(bottomfont)
		const bottomTextSizes = surface.GetTextSize(bottomtext)
		const bw = bottomTextSizes[0], bh = bottomTextSizes[1]
		const y1 = h / 2 - bh / 2, y2 = h / 2 + th / 2
		let x = 0
		if (alignment == TEXT_ALIGN.TEXT_ALIGN_LEFT) {
			x = 0
		} else if (alignment == TEXT_ALIGN.TEXT_ALIGN_CENTER) {
			x = w / 2
		} else if (alignment == TEXT_ALIGN.TEXT_ALIGN_RIGHT) {
			x = w
		}
		draw.SimpleText(toptext, topfont, x, y1 + centerSpacing, topcol, alignment, TEXT_ALIGN.TEXT_ALIGN_CENTER)
		draw.SimpleText(bottomtext, bottomfont, x, y2 - centerSpacing, bottomcol, alignment, TEXT_ALIGN.TEXT_ALIGN_CENTER)
	})
}
classes.Blur = function (this: Panel | any, amount: number) {
	this.On("Paint", function (this: Panel, w: number, h: number) {
		const locals = this.LocalToScreen(0, 0)
		const x = locals[0], y = locals[1]
		const scrW = ScrW(), scrH = ScrH()
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(blur)
		for (let i = 1; i < 3; i++) {
			// update @glua-ts/types
			blur.SetFloat("$blur", (i / 3) * (amount || 8))
			blur.Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
		}
	})
}
classes.CircleClick = function (this: Panel | any, col: Color, speed: number, trad: NUM) {
	col = col || Color(255, 255, 255, 50)
	speed = speed || 5
	this.Rad, this.Alpha, this.ClickX, this.ClickY = 0, 0, 0, 0
	this.On("Paint", function (this: Panel | any, w: number, h: number) {
		if (this.Alpha >= 1) {
			surface.SetDrawColor(ColorAlpha(col, this.Alpha))
			draw.NoTexture()
			drawCircle(this.ClickX, this.ClickY, this.Rad)
			this.Rad = Lerp(FrameTime() * speed, this.Rad, trad || w)
			this.Alpha = Lerp(FrameTime() * speed, this.Alpha, 0)
		}
	})
	this.On("DoClick", function (this: Panel | any) {
		const cursorpos = this.CursorPos()
		this.ClickX = cursorpos[0]
		this.ClickY = cursorpos[1]
		this.Rad = 0
		this.Alpha = col.a
	})
}
classes.CircleHover = function (this: Panel | any, col: Color, speed: number, trad: number) {
	col = col || Color(255, 255, 255, 30)
	speed = speed || 6
	this.LastX = 0, this.LastY = 0
	this.SetupTransition("CircleHover", speed, TDLibUtil.HoverFunc)
	this.On("Think", function (this: Panel | any) {
		if (this.IsHovered()) {
			const cursorpos = this.CursorPos()
			this.LastX = cursorpos[0], this.LastY = cursorpos[1]
		}
	})
	this.On("PaintOver", function (this: Panel | any, w: number, h: number) {
		draw.NoTexture()
		surface.SetDrawColor(ColorAlpha(col, col.a * this.CircleHover))
		drawCircle(this.LastX, this.LastY, this.CircleHover * (trad || w))
	})
}
classes.SquareCheckbox = function (this: Panel | any, inner: Color | IColor, outer: Color | IColor, speed: number) {
	inner = inner || Color(0, 255, 0, 255)
	outer = outer || Color(255, 255, 255, 255)
	speed = speed || 14
	this.SetupTransition("SquareCheckbox", speed, function (this: Panel | any) { return this.GetChecked() })
	this.On("Paint", function (this: Panel | any, w: number, h: number) {
		surface.SetDrawColor(outer)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(inner)
		surface.DrawOutlinedRect(0, 0, w, h)
		let bw = (w - 4) * this.SquareCheckbox, bh = (h - 4) * this.SquareCheckbox
		bw = math.Round(bw), bh = math.Round(bh)
		surface.DrawRect(w / 2 - bw / 2, h / 2 - bh / 2, bw, bh)
	})
}
classes.CircleCheckbox = function (this: Panel | any, inner: Color, outer: Color, speed: number) {
	inner = inner || Color(0, 255, 0, 255)
	outer = outer || Color(255, 255, 255, 255)
	speed = speed || 14
	this.SetupTransition("CircleCheckbox", speed, function (this: Panel | any) { return this.GetChecked() })
	this.On("Paint", function (this: Panel | any, w: number, h: number) {
		draw.NoTexture()
		surface.SetDrawColor(outer)
		drawCircle(w / 2, h / 2, w / 2 - 1)

		surface.SetDrawColor(inner)
		drawCircle(w / 2, h / 2, w * this.CircleCheckbox / 2)
	})
}
/*
classes.AvatarMask = function(pnl, mask)
	pnl.Avatar = vgui.Create("AvatarImage", pnl)
	pnl.Avatar:SetPaintedManually(true)
	pnl.Paint = function(s, w, h)
		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
		render.SetStencilPassOperation(STENCILOPERATION_ZERO)
		render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
		render.SetStencilReferenceValue(1)
		draw.NoTexture()
		surface.SetDrawColor(255, 255, 255, 255)
		mask(s, w, h)
		render.SetStencilFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilReferenceValue(1)
		s.Avatar:SetPaintedManually(false)
		s.Avatar:PaintManual()
		s.Avatar:SetPaintedManually(true)
		render.SetStencilEnable(false)
		render.ClearStencil()
	end
	pnl.PerformLayout = function(s)
		s.Avatar:SetSize(s:GetWide(), s:GetTall())
	end
	pnl.SetPlayer = function(s, ply, size) s.Avatar:SetPlayer(ply, size) end
	pnl.SetSteamID = function(s, id, size) s.Avatar:SetSteamID(id, size) end
end
classes.CircleAvatar = function(pnl)
	pnl:Class("AvatarMask", function(s, w, h)
		drawCircle(w/2, h/2, w/2)
	end)
end
classes.Circle = function(pnl, col)
	col = col || Color(255, 255, 255, 255)
	pnl:On("Paint", function(s, w, h)
		draw.NoTexture()
		surface.SetDrawColor(col)
		drawCircle(w/2, h/2, math.min(w, h)/2)
	end)
end
classes.CircleFadeHover = function(pnl, col, speed)
	col = col || Color(255, 255, 255, 30)
	speed = speed || 6
	pnl:SetupTransition("CircleFadeHover", speed, TDLibUtil.HoverFunc)
	pnl:On("Paint", function(s, w, h)
		draw.NoTexture()
		surface.SetDrawColor(ColorAlpha(col, col.a*s.CircleFadeHover))
		drawCircle(w/2, h/2, math.min(w, h)/2)
	end)
end
classes.CircleExpandHover = function(pnl, col, speed)
	col = col || Color(255, 255, 255, 30)
	speed = speed || 6
	pnl:SetupTransition("CircleExpandHover", speed, TDLibUtil.HoverFunc)
	pnl:On("Paint", function(s, w, h)
		local rad = math.Round(w/2*s.CircleExpandHover)
		draw.NoTexture()
		surface.SetDrawColor(ColorAlpha(col, col.a*s.CircleExpandHover))
		drawCircle(w/2, h/2, rad)
	end)
end
classes.Gradient = function(pnl, col, dir, frac, op)
	dir = dir || BOTTOM
	frac = frac || 1
	pnl:On("Paint", function(s, w, h)
		surface.SetDrawColor(col)
		local x, y, gw, gh		
		if(dir == LEFT) then
			local prog = math.Round(w*frac)
			x, y, gw, gh = 0, 0, prog, h
			surface.SetMaterial(op && gradRight || gradLeft)
		elseif(dir == TOP) then
			local prog = math.Round(h*frac)
			x, y, gw, gh = 0, 0, w, prog
			surface.SetMaterial(op && gradDown || gradUp)
		elseif(dir == RIGHT) then
			local prog = math.Round(w*frac)
			x, y, gw, gh = w-prog, 0, prog, h
			surface.SetMaterial(op && gradLeft || gradRight)
		elseif(dir == BOTTOM) then
			local prog = math.Round(h*frac)
			x, y, gw, gh = 0, h-prog, w, prog
			surface.SetMaterial(op && gradUp || gradDown)
		end
		surface.DrawTexturedRect(x, y, gw, gh)
	end)
end
classes.SetOpenURL = function(pnl, url)
	pnl:On("DoClick", function()
		gui.OpenURL(url)
	end)
end
classes.NetMessage = function(pnl, name, data)
	data = data || function() end
	pnl:On("DoClick", function()
		net.Start(name)
			data(pnl)
		net.SendToServer()
	end)
end
classes.Stick = function(pnl, dock, margin, dontInvalidate)
	dock = dock || FILL
	margin = margin || 0
	pnl:Dock(dock)
	if(margin > 0) then
		pnl:DockMargin(margin, margin, margin, margin)
	end
	if(!dontInvalidate) then
		pnl:InvalidateParent(true)
	end
end
classes.DivTall = function(pnl, frac, target)
	frac = frac || 2
	target = target || pnl:GetParent()
	pnl:SetTall(target:GetTall()/frac)
end
classes.DivWide = function(pnl, frac, target)
	target = target || pnl:GetParent()
	frac = frac || 2
	pnl:SetWide(target:GetWide()/frac)
end
classes.SquareFromHeight = function(pnl)
	pnl:SetWide(pnl:GetTall())
end
classes.SquareFromWidth = function(pnl)
	pnl:SetTall(pnl:GetWide())
end
classes.SetRemove = function(pnl, target)
	target = target || pnl
	pnl:On("DoClick", function()
		if(IsValid(target)) then target:Remove() end
	end)
end
classes.FadeIn = function(pnl, time, alpha)
	time = time || 0.2
	alpha = alpha || 255
	pnl:SetAlpha(0)
	pnl:AlphaTo(alpha, time)
end
classes.HideVBar = function(pnl)
	local vbar = pnl:GetVBar()
	vbar:SetWide(0)
	vbar:Hide()
end
classes.SetTransitionFunc = function(pnl, fn)
	pnl.TransitionFunc = fn
end
classes.ClearTransitionFunc = function(pnl)
	pnl.TransitionFunc = nil
end
classes.SetAppendOverwrite = function(pnl, fn)
	pnl.AppendOverwrite = fn
end
classes.ClearAppendOverwrite = function(pnl)
	pnl.AppendOverwrite = nil
end
classes.ClearPaint = function(pnl)
	pnl.Paint = nil
end
classes.ReadyTextbox = function(pnl)
	pnl:SetPaintBackground(false)
	pnl:SetAppendOverwrite("PaintOver")
		:SetTransitionFunc(function(s) return s:IsEditing() end)
end
*/
export function TDLib(this: void, c: string, p?: Panel, n?: string) {
	const dpanel = vgui.Create(c, p as Panel, n as string) as any
	dpanel.Class = function (this: Panel, name: string, ...items: any[]) {
		const cls = classes[name] as (this: void, self: Panel, ...items: any[]) => void
		assert(cls, `[TDLib.ts]: Class "${name}" does not exist.`)
		cls(this, items)
		return this
	}
	for (const k in classes) {
		dpanel[k] = function (this: Panel | any, ...items: any[]) { return this.Class(k, items) }
	}
	return dpanel
}
