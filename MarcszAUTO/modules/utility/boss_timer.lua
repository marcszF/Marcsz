-- =========================================
-- MODULE: Boss Timer
-- =========================================
-- Countdown timer for boss raids with alarms

local bossConfig = CONFIG.boss

local lastAlarmTime = ""

-- Time helper functions
local function getSecondsSinceMidnight()
    local t = os.date("*t")
    return t.hour * 3600 + t.min * 60 + t.sec
end

local function timeToSeconds(hhmm)
    local h, m = string.match(hhmm, "(%d+):(%d+)")
    return tonumber(h) * 3600 + tonumber(m) * 60
end

local function getNextRaid()
    local now = getSecondsSinceMidnight()
    for _, timeStr in ipairs(bossConfig.raidHours) do
        local raidSec = timeToSeconds(timeStr)
        if raidSec > now then
            return raidSec - now, timeStr
        end
    end
    local firstRaidSec = timeToSeconds(bossConfig.raidHours[1])
    return (24 * 3600 - now) + firstRaidSec, bossConfig.raidHours[1]
end

-- Boss Timer Macro
local bossMacro = macro(1000, "Boss Timer", function()
    local remaining, nextTime = getNextRaid()
    
    local hrs = math.floor(remaining / 3600)
    local mins = math.floor((remaining % 3600) / 60)
    local secs = remaining % 60
    local timeStr = string.format("%02d:%02d:%02d", hrs, mins, secs)
    
    if bossIcon then
        bossIcon:setText("\n\n" .. nextTime .. "\n" .. timeStr)
        
        if remaining < 120 then
            bossIcon:setColor("red") 
        else
            bossIcon:setColor("white")
        end
    end

    -- Trigger alarm
    if remaining <= bossConfig.alarmSeconds and lastAlarmTime ~= nextTime then
        playSound("Alarme/" .. bossConfig.sound)
        
        if g_window and g_window.flash then
            g_window.flash()
        end
        
        modules.game_textmessage.displayGameMessage("BOSS EM " .. remaining .. " SEGUNDOS!")
        lastAlarmTime = nextTime
    end
end)

-- Boss Icon
bossIcon = addIcon("BossTimer", {item=2036, text="", moveable=true}, bossMacro)
bossIcon:setSize({height=85, width=50})

UI.Separator()
