-- =========================================
-- MARCSZ AUTO - GLOBAL CONFIGURATION
-- =========================================
-- Edit these values to customize your bot behavior

local config = {}

-- Boss Timer Configuration
config.boss = {
    alarmSeconds = 60,            -- Alert X seconds before boss
    sound = "AlarmClock.wav",     -- Sound file name
    raidHours = {                 -- Boss spawn times
        "01:30", "03:30", "05:30", "07:30", "09:30", "11:30",
        "13:30", "15:30", "17:30", "19:30", "21:30", "23:30"
    }
}

-- House Trainer Configuration
config.trainer = {
    house = { 
        x1 = 1051, y1 = 1040, 
        x2 = 1057, y2 = 1044, 
        z = 7 
    },
    dummy = { 
        id = 54005, 
        pos = {x = 1051, y = 1043, z = 7}
    },
    wands = {55486, 55484, 55634}, -- Priority: Left to Right
    delay = 1500                   -- Attack delay in milliseconds
}

-- Dodge System Configuration
config.dodge = {
    forbiddenId = 55636,  -- Dangerous floor ID (fire/damage)
    anchorId = 10145,     -- Safe floor ID (anchor point)
    ranges = {
        anchorSearch = 7, -- Distance to search for anchor
        dangerScan = 5    -- Radius to check for mechanics
    },
    returnDelay = 500     -- Time to wait before returning (ms)
}

-- Turbo Follow Configuration
config.follow = {
    distance = 1,                -- Target distance (1 = adjacent)
    interactionDelay = 100,      -- Min delay between interactions (ms)
    checkInterval = 50           -- How often to check position (ms)
}

-- Auto Utilities Configuration
config.utilities = {
    renewTaskInterval = 120000,  -- Task renew interval (2 min)
    sellDepositInterval = 30000, -- Auto sell/deposit (30 sec)
    sellItemId = 54995,
    depositItemId = 54991,
    blessItemId = 54531
}

-- Money Converter Configuration
config.money = {
    items = {3031, 3035}  -- Gold coin IDs to stack
}

-- Anti-Push Configuration
config.antiPush = {
    dropItems = {3031, 3035},  -- Items to drop
    maxStackedItems = 10,      -- Max items per tile
    dropDelay = 600            -- Delay between drops (ms)
}

-- Portal and Teleport IDs
config.portals = {
    useIds = {  -- Items that need right-click (manholes, etc)
        433, 435, 482, 1948, 1968, 5542, 7771, 9116, 12799, 17230, 20469, 20474, 
        20488, 20489, 20895, 20896, 28209, 28210, 28656, 31129, 31130, 31262, 33770, 
        34324, 43374
    },
    stepIds = {  -- Items that need walking on (portals, stairs)
        166, 167, 413, 427, 428, 433, 437, 438, 465, 468, 566, 855, 856, 857, 
        1947, 1950, 1951, 1952, 1953, 1954, 1955, 1956, 1957, 1958, 1977, 1978, 
        4823, 5081, 5257, 5258, 5259, 7881, 7888, 8657, 8658, 8690, 8932, 10206, 
        11707, 11709, 14133, 15144, 15145, 15146, 15147, 15718, 16272, 17394, 17395, 
        15590, 15591, 20123, 20124, 20142, 20224, 20225, 20253, 20254, 20255, 20256, 
        20257, 20258, 20259, 20328, 20329, 20330, 20331, 20332, 20333, 20334, 20335, 
        20336, 20491, 20492, 20493, 20494, 20495, 20496, 20750, 20751, 20752, 20753, 
        20754, 20755, 21365, 21564, 21566, 21568, 21570, 21156, 22517, 22565, 22566
    }
}

return config
