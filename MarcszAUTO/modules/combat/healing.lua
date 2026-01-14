-- =========================================
-- MODULE: Healing System
-- =========================================
-- Auto-healing with potions and spells

UI.Separator()

-- Single Heal Spell
if type(storage.singleHeal) ~= "table" then
    storage.singleHeal = {
        on = false, 
        title = "HP%", 
        text = "exura gran san", 
        min = 0, 
        max = 90
    }
end

local healMacro = macro(20, function()
    local hp = player:getHealthPercent()
    if storage.singleHeal.max >= hp and hp >= storage.singleHeal.min then
        if TargetBot then 
            TargetBot.saySpell(storage.singleHeal.text) 
        else
            say(storage.singleHeal.text)
        end
    end
end)

healMacro.setOn(storage.singleHeal.on)

UI.DualScrollPanel(storage.singleHeal, function(widget, newParams) 
    storage.singleHeal = newParams
    healMacro.setOn(storage.singleHeal.on)
end)

UI.Separator()

-- Potion Healing
Panels.HealthItem() 
UI.Separator()

-- Anti-Paralyze
Panels.AntiParalyze()
UI.Separator()

-- Haste (Speed Spell)
Panels.Haste()
UI.Separator()
