-- =========================================
-- MODULE: Basic Follow
-- =========================================
-- Simple follow and follow attack systems

local followName = "autofollow"
if not storage[followName] then 
    storage[followName] = {player = 'name'} 
end

local toFollowPos = {}

addSeparator()

followTE = UI.TextEdit(storage[followName].player or "name", function(widget, newText)
    storage[followName].player = newText
end)

-- Standard Follow (uses game follow)
local followChange = macro(1000, "Follow", function()
    local followw = storage[followName].player 
    if g_game.isFollowing() then
        return
    end
    
    for _, followcreature in ipairs(g_map.getSpectators(pos(), false)) do
        if followcreature:getName() == followw and getDistanceBetween(pos(), followcreature:getPosition()) <= 8 then
            g_game.follow(followcreature)
        end
    end
end)

-- Follow Attack (walks to target's position)
local followMacro = macro(20, "Follow Attack", function()
    local target = getCreatureByName(storage[followName].player)
    if target then
        local tpos = target:getPosition()
        toFollowPos[tpos.z] = tpos
    end
    
    if player:isWalking() then
        return
    end
    
    local p = toFollowPos[posz()]
    if not p then
        return
    end
    
    if autoWalk(p, 20, {ignoreNonPathable = true, precision = 1}) then
        delay(100)
    end
end)

UI.Separator()

-- Update follow name when following changes
onPlayerPositionChange(function(newPos, oldPos)
    if followChange:isOff() then return end
    if g_game.isFollowing() then
        tfollow = g_game.getFollowingCreature()

        if tfollow then
            if tfollow:getName() ~= storage[followName].player then
                followTE:setText(tfollow:getName())
                storage[followName].player = tfollow:getName()
            end
        end
    end
end)

-- Track creature position changes
onCreaturePositionChange(function(creature, newPos, oldPos)
    if creature:getName() == storage[followName].player and newPos then
        toFollowPos[newPos.z] = newPos
    end
end)

UI.Separator()

-- Sense Target (saves attack target name)
local senses = macro(2000, "Sense Target", "shift+f", function()
    if sense then 
        say('sense "' .. sense)
    end
end)

macro(1, function() 
    if g_game.isAttacking() and g_game.getAttackingCreature():isPlayer() then 
        sense = g_game.getAttackingCreature():getName() 
    end 
end)

UI.Separator()
