local ____exports = {}
local blur = ({
    Material("pp/blurscreen")
})[1]
local gradLeft = ({
    Material("vgui/gradient-l")
})[1]
local gradUp = ({
    Material("vgui/gradient-u")
})[1]
local gradRight = ({
    Material("vgui/gradient-r")
})[1]
local gradDown = ({
    Material("vgui/gradient-d")
})[1]
local TDLibUtil = {}
TDLibUtil.DrawCircle = function(x, y, r, col)
    local circle = {}
    do
        local i = 1
        while i < 360 do
            circle[i + 1] = {}
            circle[i + 1].x = x + (math.cos(
                math.rad(i * 360) / 360
            ) * r)
            circle[i + 1].y = y + (math.sin(
                math.rad(i * 360) / 360
            ) * r)
            i = i + 1
        end
    end
    surface.SetDrawColor(col)
    draw.NoTexture()
    surface.DrawPoly(circle)
end
TDLibUtil.DrawArc = function(x, y, ang, p, rad, color, seg)
    seg = seg or 80
    ang = -ang + 180
    local circle = {}
    table.insert(circle, {x = x, y = y})
    do
        local i = 0
        while i < seg do
            local a = math.rad(((i / seg) * -p) + ang)
            table.insert(
                circle,
                {
                    x = x + (math.sin(a) * rad),
                    y = y + (math.cos(a) * rad)
                }
            )
            i = i + 1
        end
    end
    surface.SetDrawColor(color)
    draw.NoTexture()
    surface.DrawPoly(circle)
end
TDLibUtil.LerpColor = function(frac, from, to)
    return Color(
        Lerp(frac, from.r, to.r),
        Lerp(frac, from.g, to.g),
        Lerp(frac, from.b, to.b),
        Lerp(frac, from.a, to.a)
    )
end
TDLibUtil.HoverFunc = function(s)
    return s:IsHovered()
end
TDLibUtil.HoverFuncChild = function(s)
    return s:IsHovered() or s:IsChildHovered(false)
end
local function drawCircle(x, y, r)
    local circle = {}
    do
        local i = 0
        while i < 360 do
            circle[i + 1] = {
                x = x + (math.cos(
                    math.rad(i * 360) / 360
                ) * r),
                y = y + (math.sin(
                    math.rad(i * 360) / 360
                ) * r)
            }
            i = i + 1
        end
    end
    surface.DrawPoly(circle)
end
local classes = {}
classes.On = function(self, name, fn)
    name = self.AppendOverwrite or name
    local old = self[name]
    self[name] = function(self, s, ...)
        local items = {...}
        if old then
            old(nil, s, items)
        end
        fn(nil, s, items)
    end
end
classes.SetupTransition = function(self, name, speed, fn)
    fn = self.TransitionFunc or fn
    self[name] = 0
    self:On(
        "Think",
        function(self, s)
            s[name] = Lerp(
                FrameTime() * speed,
                s[name],
                (fn(nil, s) and 1) or 0
            )
        end
    )
end
classes.FadeHover = function(self, col, speed, rad)
    col = col or Color(255, 255, 255, 30)
    speed = speed or 6
    self:SetupTransition("FadeHover", speed, TDLibUtil.HoverFunc)
    self:On(
        "Paint",
        function(self, w, h)
            local col1 = ColorAlpha(col, col.a * self.FadeHover)
            if rad and (rad > 0) then
                draw.RoundedBox(rad, 0, 0, w, h, col1)
            end
            surface.SetDrawColor(col1)
            surface.DrawRect(0, 0, w, h)
        end
    )
end
classes.BarHover = function(self, col, height, speed)
    col = col or Color(255, 255, 255, 255)
    height = height or 2
    speed = speed or 6
    self:SetupTransition("BarHover", speed, TDLibUtil.HoverFunc)
    self:On(
        "PaintOver",
        function(self, w, h)
            local bar = math.Round(w * self.BarHover)
            surface.SetDrawColor(col)
            surface.DrawRect((w / 2) - (bar / 2), h - height, bar, height)
        end
    )
end
classes.FillHover = function(self, col, dir, speed, mat)
    col = col or Color(255, 255, 255, 30)
    dir = dir or LEFT
    speed = speed or 8
    self:SetupTransition("FillHover", speed, TDLibUtil.HoverFunc)
    self:On(
        "PaintOver",
        function(self, w, h)
            surface.SetDrawColor(col)
            local x = ((dir == RIGHT) and math.Round(w * self.FillHover)) or 0
            local prog = math.Round(h * self.FillHover)
            local y = ((dir == BOTTOM) and (h - prog)) or 0
            local fw = ((dir == LEFT) and math.Round(w * self.FillHover)) or (((dir == RIGHT) and prog) or w)
            local fh = ((dir == TOP) and math.Round(h * self.FillHover)) or (((dir == BOTTOM) and prog) or h)
            if mat then
                surface.SetMaterial(mat)
                surface.DrawTexturedRect(x, y, fw, fh)
            else
                surface.DrawRect(x, y, fw, fh)
            end
        end
    )
end
classes.Background = function(self, col, rad, rtl, rtr, rbl, rbr)
    self:On(
        "Paint",
        function(self, w, h)
            if rad and (rad > 0) then
                if rtl ~= nil then
                    draw.RoundedBoxEx(rad, 0, 0, w, h, col, rtl, rtr, rbl, rbr)
                else
                    draw.RoundedBox(rad, 0, 0, w, h, col)
                end
            else
                surface.SetDrawColor(col)
                surface.DrawRect(0, 0, w, h)
            end
        end
    )
end
classes.Material = function(self, mat, col)
    col = col or Color(255, 255, 255, 255)
    self:On(
        "Paint",
        function(self, w, h)
            surface.SetDrawColor(col)
            surface.SetMaterial(mat)
            surface.DrawTexturedRect(0, 0, w, h)
        end
    )
end
classes.TiledMaterial = function(self, mat, tw, th, col)
    col = col or Color(255, 255, 255, 255)
    self:On(
        "Paint",
        function(self, w, h)
            surface.SetMaterial(mat)
            surface.SetDrawColor(col)
            surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / tw, h / th)
        end
    )
end
classes.Outline = function(self, col, width)
    col = col or Color(255, 255, 255, 255)
    width = width or 1
    self:On(
        "Paint",
        function(self, w, h)
            surface.SetDrawColor(col)
            do
                local i = 0
                while i < (width - 1) do
                    surface.DrawOutlinedRect(0 + i, 0 + i, w - (i * 2), h - (i * 2))
                    i = i + 1
                end
            end
        end
    )
end
classes.LinedCorners = function(self, col, len)
    col = col or Color(255, 255, 255, 255)
    len = len or 15
    self:On(
        "Paint",
        function(self, w, h)
            surface.SetDrawColor(col)
            surface.DrawRect(0, 0, len, 1)
            surface.DrawRect(0, 1, 1, len - 1)
            surface.DrawRect(w - len, h - 1, len, 1)
            surface.DrawRect(w - 1, h - len, 1, len - 1)
        end
    )
end
classes.SideBlock = function(self, col, size, side)
    col = col or Color(255, 255, 255, 255)
    size = size or 3
    side = side or LEFT
    self:On(
        "Paint",
        function(self, w, h)
            surface.SetDrawColor(col)
            if side == LEFT then
                surface.DrawRect(0, 0, size, h)
            elseif side == TOP then
                surface.DrawRect(0, 0, w, size)
            elseif side == RIGHT then
                surface.DrawRect(w - size, 0, size, h)
            elseif side == BOTTOM then
                surface.DrawRect(0, h - size, w, size)
            end
        end
    )
end
classes.Text = function(self, text, font, col, alignment, ox, oy, paint)
    font = font or "Trebuchet24"
    col = col or Color(255, 255, 255, 255)
    alignment = alignment or TEXT_ALIGN_CENTER
    ox = ox or 0
    oy = oy or 0
    if (((not paint) and self.SetText) and self.SetFont) and self.SetTextColor then
        self:SetText(text)
        self:SetFont(font)
        self:SetTextColor(col)
    else
        self:On(
            "Paint",
            function(self, w, h)
                local x = 0
                if alignment == TEXT_ALIGN_CENTER then
                    x = w / 2
                elseif alignment == TEXT_ALIGN_RIGHT then
                    x = w
                end
                draw.SimpleText(text, font, x + ox, (h / 2) + oy, col, alignment, TEXT_ALIGN_CENTER)
            end
        )
    end
end
classes.DualText = function(self, toptext, topfont, topcol, bottomtext, bottomfont, bottomcol, alignment, centerSpacing)
    topfont = topfont or "Trebuchet24"
    topcol = topcol or Color(0, 127, 255, 255)
    bottomfont = bottomfont or "Trebuchet18"
    bottomcol = bottomcol or Color(255, 255, 255, 255)
    alignment = alignment or TEXT_ALIGN_CENTER
    centerSpacing = centerSpacing or 0
    self:On(
        "Paint",
        function(self, w, h)
            surface.SetFont(topfont)
            local textSizes = surface.GetTextSize(toptext)
            local tw = textSizes[1]
            local th = textSizes[2]
            surface.SetFont(bottomfont)
            local bottomTextSizes = surface.GetTextSize(bottomtext)
            local bw = bottomTextSizes[1]
            local bh = bottomTextSizes[2]
            local y1 = (h / 2) - (bh / 2)
            local y2 = (h / 2) + (th / 2)
            local x = 0
            if alignment == TEXT_ALIGN_LEFT then
                x = 0
            elseif alignment == TEXT_ALIGN_CENTER then
                x = w / 2
            elseif alignment == TEXT_ALIGN_RIGHT then
                x = w
            end
            draw.SimpleText(toptext, topfont, x, y1 + centerSpacing, topcol, alignment, TEXT_ALIGN_CENTER)
            draw.SimpleText(bottomtext, bottomfont, x, y2 - centerSpacing, bottomcol, alignment, TEXT_ALIGN_CENTER)
        end
    )
end
classes.Blur = function(self, amount)
    self:On(
        "Paint",
        function(self, w, h)
            local locals = {
                self:LocalToScreen(0, 0)
            }
            local x = locals[1]
            local y = locals[2]
            local scrW = ScrW()
            local scrH = ScrH()
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(blur)
            do
                local i = 1
                while i < 3 do
                    blur:SetFloat("$blur", (i / 3) * (amount or 8))
                    blur:Recompute()
                    render.UpdateScreenEffectTexture()
                    surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
                    i = i + 1
                end
            end
        end
    )
end
function ____exports.TDLib(c, p, n)
    local dpanel = vgui.Create(c, p, n)
    dpanel.Class = function(self, name, ...)
        local items = {...}
        local cls
        cls = classes[name]
        assert(
            cls,
            ("[TDLib.ts]: Class \"" .. tostring(name)) .. "\" does not exist."
        )
        cls(self, items)
        return self
    end
    for k in pairs(classes) do
        dpanel[k] = function(self, ...)
            local items = {...}
            return self:Class(k, items)
        end
    end
    return dpanel
end
return ____exports
