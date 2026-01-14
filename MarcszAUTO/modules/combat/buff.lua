-- =========================================
-- MODULE: Buff System
-- =========================================
-- Auto-buff management (utito, etc.)

local buffMacro = macro(1000, "Buff System", function()
    -- Only buff if not in party and not in PZ
    if not hasPartyBuff() and not isInPz() then
        if storage.buff1 and storage.buff1:len() > 0 then
            say(storage.buff1)
        end
    end
end)

UI.Label("Buff:")
addTextEdit("buff1", storage.buff1 or "utito tempo san", function(widget, text) 
    storage.buff1 = text
end)

UI.Separator()
