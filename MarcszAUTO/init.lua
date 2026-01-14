-- =========================================
-- MARCSZ AUTO - MAIN LOADER
-- =========================================
-- This file loads all modules in the correct order
-- To add new features, simply create a new file in the 
-- appropriate modules folder and add it here

print("=================================")
print("   MARCSZ AUTO - Loading...     ")
print("=================================")

-- Load core libraries first
dofile("lib/vlib.lua")

-- Load configuration and make it globally available
CONFIG = dofile("config/settings.lua")

-- =========================================
-- UI MODULES (Visual elements)
-- =========================================
dofile("modules/ui/rainbow_title.lua")
dofile("modules/ui/position_display.lua")

-- =========================================
-- COMBAT MODULES (Fighting features)
-- =========================================
dofile("modules/combat/attack.lua")
dofile("modules/combat/healing.lua")
dofile("modules/combat/buff.lua")
dofile("modules/combat/dodge.lua")

-- =========================================
-- UTILITY MODULES (Helper features)
-- =========================================
dofile("modules/utility/boss_timer.lua")
dofile("modules/utility/house_trainer.lua")
dofile("modules/utility/money_converter.lua")
dofile("modules/utility/auto_utilities.lua")
dofile("modules/utility/general_utils.lua")
dofile("modules/utility/spy_level.lua")
dofile("modules/utility/bug_map.lua")

-- =========================================
-- MOVEMENT MODULES (Follow and navigation)
-- =========================================
dofile("modules/movement/turbo_follow.lua")
dofile("modules/movement/follow_basic.lua")
dofile("modules/movement/anti_push.lua")

-- =========================================
-- ALARM MODULES (Alerts and notifications)
-- =========================================
dofile("modules/alarms/alarm_system.lua")

-- =========================================
-- SOCIAL MODULES (Party and friends)
-- =========================================
dofile("modules/social/friend_healer.lua")
dofile("modules/social/player_list.lua")
dofile("modules/social/auto_party.lua")

-- =========================================
-- FINALIZATION
-- =========================================
playSound("/sounds/click.ogg")
info("Marcsz Auto - Loaded Successfully!")

print("=================================")
print("   All modules loaded! ✓        ")
print("=================================")

-- HOW TO ADD NEW MODULES:
-- 1. Create your new .lua file in the appropriate folder:
--    - modules/ui/         for visual elements
--    - modules/combat/     for fighting features
--    - modules/utility/    for helper tools
--    - modules/movement/   for follow/navigation
--    - modules/alarms/     for alerts
--    - modules/social/     for party/friends
--
-- 2. Add a dofile() line above to load your module
--
-- 3. Reload the bot to test your changes
--
-- Example:
-- dofile("modules/combat/my_new_spell.lua")
