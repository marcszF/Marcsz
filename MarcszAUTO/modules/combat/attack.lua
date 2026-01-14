-- =========================================
-- MODULE: Attack System
-- =========================================
-- Auto-attack with configurable spells

UI.Separator()

-- Monster HP Display
local showhp = macro(20000, "Monstro Hp %", function() end)

onCreatureHealthPercentChange(function(creature, healthPercent)
    if showhp:isOff() then return end
    if creature:isMonster() or creature:isPlayer() and creature:getPosition() and pos() then
        if creature:getPosition() then
            creature:setText(healthPercent .. "%")
        else
            creature:clearText()
        end
    end
end)

UI.Separator()

-- Chase Mode on Attack
macro(250, "Atacar Seguindo", "Shift+R", function()
    if g_game.isOnline() and g_game.isAttacking() then
        g_game.setChaseMode(1)
    end
end)

UI.Separator()

-- Multi-Spell Attack
macro(100, "Attack", function()
    if g_game.isAttacking() then
        say(storage.magia1)
        delay(100)
        say(storage.magia2)
        delay(100)
        say(storage.magia3)
    end
end)

UI.TextEdit(storage.magia1 or "spell", function(widget, newText)
    storage.magia1 = newText
end)

UI.TextEdit(storage.magia2 or "spell2", function(widget, newText)
    storage.magia2 = newText
end)

UI.TextEdit(storage.magia3 or "spell3", function(widget, newText)
    storage.magia3 = newText
end)

UI.Separator()

-- Attack Item Panel
Panels.AttackItem(batTab)
addSeparator("sep", batTab)

UI.Separator()
