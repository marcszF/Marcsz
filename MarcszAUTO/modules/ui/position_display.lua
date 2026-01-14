-- =========================================
-- MODULE: Position Display
-- =========================================
-- Shows current player coordinates

setDefaultTab("Tools")
UI.Separator()
UI.Label("Player")

local posLabel = UI.Label("X: --  Y: --  Z: --")

macro(200, function()
    local p = g_game.getLocalPlayer()
    if not p then return end
    local pos = p:getPosition()
    posLabel:setText("X: "..pos.x.."  Y: "..pos.y.."  Z: "..pos.z)
end)

UI.Separator()
