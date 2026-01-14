-- =========================================
-- MODULE: Rainbow Title with Glitch Effect
-- =========================================
-- Creates an animated rainbow title with glitch effects

local loadPanelName = "Marcsz"

local ui = setupUI([[
Panel
  height: 15

  Label
    id: Marcsz
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 10
    height: 11
    text-align: center
    !text: tr('                 Marcsz')
]], parent)

UI.Separator()

-- Rainbow System
local rainbowHue = 0

local function hslToRgb(h, s, l)
    if s == 0 then
        local v = math.floor(l * 255)
        return v, v, v
    end

    local function hue2rgb(p, q, t)
        if t < 0 then t = t + 1 end
        if t > 1 then t = t - 1 end
        if t < 1/6 then return p + (q - p) * 6 * t end
        if t < 1/2 then return q end
        if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
        return p
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q

    local r = hue2rgb(p, q, h + 1/3)
    local g = hue2rgb(p, q, h)
    local b = hue2rgb(p, q, h - 1/3)

    return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

-- Glitch System
local baseText = "Marcsz"
local glitchChars = {"#", "@", "%", "&", "$", "*", "!", "?", "X", "Z"}

local function glitchText(text)
    local chars = {}
    for i = 1, #text do
        local c = text:sub(i,i)
        if math.random(1,12) == 1 then
            chars[i] = glitchChars[math.random(#glitchChars)]
        else
            chars[i] = c
        end
    end
    return table.concat(chars)
end

-- Rainbow + Glitch Animation Loop
macro(50, function()
    if not ui or not ui.Marcsz then return end

    -- Rainbow color
    rainbowHue = rainbowHue + 0.015
    if rainbowHue > 1 then rainbowHue = 0 end

    local r, g, b = hslToRgb(rainbowHue, 1, 0.5)
    local hex = string.format("#%02X%02X%02X", r, g, b)
    ui.Marcsz:setColor(hex)

    -- Glitch text effect
    if math.random(1,3) == 1 then
        ui.Marcsz:setText(glitchText(baseText))
    else
        ui.Marcsz:setText(baseText)
    end

    -- Shake effect
    local x = math.random(-1,1)
    local y = math.random(-1,1)
    ui.Marcsz:setMarginLeft(0 + x)
    ui.Marcsz:setMarginTop(10 + y)
end)
