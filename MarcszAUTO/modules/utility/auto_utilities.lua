-- =========================================
-- MODULE: Auto Utilities
-- =========================================
-- Auto-renew tasks, auto-sell, auto-deposit, auto-bless

local config = CONFIG.utilities

-- Task Renewal (every 2 minutes)
macro(config.renewTaskInterval, "Renovar Task (2min)", function()
    say("!taskrenew")
end)

UI.Separator()

-- Auto Sell
macro(config.sellDepositInterval, "Auto Sell (54995)", function()
    local item = findItem(config.sellItemId)
    if item then
        g_game.use(item)
    end
end)

-- Auto Deposit
macro(config.sellDepositInterval, "Auto Deposit (54991)", function()
    local item = findItem(config.depositItemId)
    if item then
        g_game.use(item)
    end
end)

UI.Separator()

-- Auto Bless System
if not storage.autoBless then
    storage.autoBless = {
        wasOnline = false,
        pending = false
    }
end

-- Detect death
onTextMessage(function(mode, text)
    if string.find(text, "You are dead") or string.find(text, "You were downgraded") then
        storage.autoBless.pending = true
        print("[AutoBless] Morte detectada! Bless agendada.")
    end
end)

-- Auto Bless on Relog/Death
macro(1000, "Auto Bless (54531)", function()
    local isOnline = g_game.isOnline()
    
    -- Detect reconnection
    if isOnline and not storage.autoBless.wasOnline then
        storage.autoBless.pending = true
        print("[AutoBless] Reconexão detectada!")
    end
    
    storage.autoBless.wasOnline = isOnline

    -- Use bless item
    if isOnline and storage.autoBless.pending then
        local item = findItem(config.blessItemId)
        if item then
            g_game.use(item)
            storage.autoBless.pending = false
            print("[AutoBless] Item usado!")
            modules.game_textmessage.displayGameMessage("AutoBless: Item Usado!")
        end
    end
end)

UI.Separator()
