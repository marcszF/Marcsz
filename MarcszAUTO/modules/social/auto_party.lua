-- =========================================
-- MODULE: Auto Party
-- =========================================
-- Auto-accept party invites when someone says "pt"

local pt = false

addSwitch("pt", "Auto PT = falar pt", function(widget)
    pt = not pt
    widget:setOn(pt)
end)

onTalk(function(name, level, mode, text, channelId, pos)
    if name == player:getName() then return end
    if mode ~= 1 then return end
    
    if string.find(text, "pt") and pt == true then
        local friend = getPlayerByName(name)
        g_game.partyInvite(friend:getId())
    end
end)

UI.Separator()
