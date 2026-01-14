-- =========================================
-- MODULE: Turbo Follow
-- =========================================
-- Advanced follow system with portal detection

local config = CONFIG.follow

-- Memory tracking
local lastKnownX, lastKnownY, lastKnownZ = 0, 0, 0
local hasLastPos = false
local lastInteraction = 0

if not storage.TurboFollowName then 
    storage.TurboFollowName = "" 
end

-- UI
UI.Label("Nome do Alvo:")
local followEdit = UI.TextEdit(storage.TurboFollowName or "", function(widget, text)
    storage.TurboFollowName = text
end)

-- Helper: Check if ID is in list
local function isIdInList(id, list)
    for i = 1, #list do
        if list[i] == id then return true end
    end
    return false
end

-- Helper: Find target by name
local function findTarget(name)
    if not name or #name < 1 then return nil end
    local player = g_game.getLocalPlayer()
    if not player then return nil end
    
    local specs = g_map.getSpectators(player:getPosition(), false)
    for _, c in ipairs(specs) do
        if c:isPlayer() and c ~= player and c:getName():lower() == name:lower() then
            return c
        end
    end
    return nil
end

-- Helper: Manhattan distance
local function getDist(pos1, pos2)
    return math.max(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y))
end

-- Check surroundings for portals/stairs
local function checkSurroundings(pPos)
    if now - lastInteraction < config.interactionDelay then return end
    
    for x = -1, 1 do
        for y = -1, 1 do
            local checkPos = {x = pPos.x + x, y = pPos.y + y, z = pPos.z}
            local tile = g_map.getTile(checkPos)
            if tile then
                local things = tile:getThings()
                for _, thing in ipairs(things) do
                    if thing:isItem() then
                        local id = thing:getId()
                        
                        -- Portal/Stairs: Walk on top
                        if isIdInList(id, CONFIG.portals.stepIds) then
                            autoWalk(checkPos, 10, {ignoreNonPathable=true, precision=0})
                            lastInteraction = now
                            return
                        end
                        
                        -- Manholes/Levers: Use
                        if isIdInList(id, CONFIG.portals.useIds) then
                            g_game.use(thing)
                            lastInteraction = now
                            return
                        end
                    end
                end
            end
        end
    end
end

-- Look event: Auto-set target name
onTextMessage(function(mode, text)
    if not followMacro or not followMacro.isOn() then return end
    if string.find(text, "You see") then
        local name = string.match(text, "You see ([^%.%(]+)")
        if name then
            name = string.gsub(name, "^%s*(.-)%s*$", "%1")
            storage.TurboFollowName = name
            if followEdit then followEdit:setText(name) end
        end
    end
end)

-- Main Turbo Follow Macro (50ms for responsiveness)
followMacro = macro(config.checkInterval, "Turbo Follow", function()
    local player = g_game.getLocalPlayer()
    if not player then return end
    local myPos = player:getPosition()
    if not myPos then return end

    local targetName = storage.TurboFollowName
    if not targetName or targetName == "" then return end

    local target = findTarget(targetName)

    -- Target visible
    if target then
        local tPos = target:getPosition()
        
        -- Update memory
        lastKnownX, lastKnownY, lastKnownZ = tPos.x, tPos.y, tPos.z
        hasLastPos = true

        local dist = getDist(myPos, tPos)
        
        -- Only walk if too far
        if dist > config.distance then
            autoWalk(tPos, 10, {ignoreNonPathable=true, precision=1})
        end
        
    -- Target disappeared: Go to last position
    elseif hasLastPos then
        local lastPos = {x=lastKnownX, y=lastKnownY, z=lastKnownZ}
        local dist = getDist(myPos, lastPos)
        
        if dist > 1 then
            autoWalk(lastPos, 10, {ignoreNonPathable=true, precision=1})
        else
            -- Check for portals/stairs
            checkSurroundings(lastPos)
        end
    end
end)

UI.Separator()
