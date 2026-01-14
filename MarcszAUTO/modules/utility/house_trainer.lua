-- =========================================
-- MODULE: House Trainer
-- =========================================
-- Automatically attack training dummies in house

local trainerConfig = CONFIG.trainer

-- Check if player is inside house
local function isInsideHouse()
    local p = pos() 
    return p.z == trainerConfig.house.z 
       and p.x >= trainerConfig.house.x1 and p.x <= trainerConfig.house.x2
       and p.y >= trainerConfig.house.y1 and p.y <= trainerConfig.house.y2
end

-- Get priority wand from inventory
local function getPriorityWand()
    for _, id in ipairs(trainerConfig.wands) do
        local item = findItem(id) 
        if item then
            return item
        end
    end
    return nil
end

-- Get dummy from tile
local function getDummyThing()
    local tile = g_map.getTile(trainerConfig.dummy.pos)
    if not tile then return nil end
    
    for _, thing in ipairs(tile:getThings()) do
        if thing:getId() == trainerConfig.dummy.id then
            return thing
        end
    end
    return nil
end

-- House Trainer Macro
local HouseMacro = macro(trainerConfig.delay, "House Trainer", function()
    if not isInsideHouse() then return end

    local targetDummy = getDummyThing()
    if not targetDummy then return end

    local wandItem = getPriorityWand()
    
    if wandItem then
        g_game.useWith(wandItem, targetDummy)
    end
end)

-- Trainer Icon
addIcon("Trainer", {item=55486, text="Trainer", moveable=true}, HouseMacro)

UI.Separator()
