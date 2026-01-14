-- =========================================
-- MODULE: Boss Dodge System
-- =========================================
-- Smart dodging of boss mechanics (fire floors, etc.)

local dodgeConfig = CONFIG.dodge

-- Track last mechanic time
if not storage.lastMechanicTime then
    storage.lastMechanicTime = 0
end

-- Check if item exists on position
local function hasItemOnPos(pos, itemId)
    local tile = g_map.getTile(pos)
    if tile then
        local things = tile:getThings()
        for _, thing in ipairs(things) do
            if thing:getId() == itemId then
                return true
            end
        end
    end
    return false
end

-- Scan area for dangerous mechanics
local function isMechanicNearby(pos, range)
    for x = -range, range do
        for y = -range, range do
            local checkPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            if hasItemOnPos(checkPos, dodgeConfig.forbiddenId) then
                return true
            end
        end
    end
    return false
end

-- Find nearest safe anchor
local function getSafeAnchor(pos)
    local bestPos = nil
    local minDist = 999

    for x = -dodgeConfig.ranges.anchorSearch, dodgeConfig.ranges.anchorSearch do
        for y = -dodgeConfig.ranges.anchorSearch, dodgeConfig.ranges.anchorSearch do
            local checkPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            
            -- Check if it's the anchor floor
            if hasItemOnPos(checkPos, dodgeConfig.anchorId) then
                -- Make sure this anchor isn't on fire
                if not hasItemOnPos(checkPos, dodgeConfig.forbiddenId) then
                    local dist = getDistanceBetween(pos, checkPos)
                    if dist < minDist then
                        minDist = dist
                        bestPos = checkPos
                    end
                end
            end
        end
    end
    return bestPos
end

-- Main Dodge Logic
macro(200, "Boss Dodge Logic", function()
    local player = g_game.getLocalPlayer()
    if not player then return end
    
    local playerPos = player:getPosition()
    
    -- Emergency: Standing on danger
    local standingOnDanger = hasItemOnPos(playerPos, dodgeConfig.forbiddenId)

    if standingOnDanger then
        storage.lastMechanicTime = now
        
        local safeSpot = getSafeAnchor(playerPos)
        if safeSpot then
            if not player:isWalking() then
                autoWalk(safeSpot, 10, {ignoreNonPathable = true, precision = 1})
            end
        end
        return 
    end

    -- Alert: Mechanic nearby, stay put
    if isMechanicNearby(playerPos, dodgeConfig.ranges.dangerScan) then
        storage.lastMechanicTime = now
        return
    end

    -- Safe: Return to combat
    local timeSinceGone = now - storage.lastMechanicTime
    
    if timeSinceGone >= dodgeConfig.returnDelay then
        local target = g_game.getAttackingCreature()
        if target then
            local targetPos = target:getPosition()
            if getDistanceBetween(playerPos, targetPos) > 1 then
                autoWalk(targetPos, 20, {ignoreNonPathable = true, precision = 1})
            end
        end
    end
end)

UI.Separator()
