-- =========================================
-- MODULE: Anti-Push
-- =========================================
-- Drop items on ground to prevent being pushed

local CONFIG = dofile("config/settings.lua")
local config = CONFIG.antiPush

addSeparator()

gpAntiPushDrop = macro(config.dropDelay, "Anti-Push", "shift+d", function()
    antiPush()
end)

onPlayerPositionChange(function()
    antiPush()
end)

function antiPush()
    if gpAntiPushDrop:isOff() then
        return
    end

    local tile = g_map.getTile(pos())
    if tile and tile:getThingCount() < config.maxStackedItems then
        local thing = tile:getTopThing()
        if thing and not thing:isNotMoveable() then
            for i, item in pairs(config.dropItems) do
                if item ~= thing:getId() then
                    local dropItem = findItem(item)
                    if dropItem then
                        g_game.move(dropItem, pos(), 2)
                    end
                end
            end
        end
    end
end

UI.Separator()
