# Contributing to Marcsz Auto

Thank you for your interest in contributing! This guide will help you add new features to the bot.

## 📁 Project Organization

The project is organized into logical modules:

```
modules/
├── ui/          - User interface components (titles, displays)
├── combat/      - Combat features (attack, heal, buff, dodge)
├── utility/     - Utility tools (timers, trainers, converters)
├── movement/    - Movement systems (follow, navigation)
├── alarms/      - Alert systems (HP, players, etc.)
└── social/      - Social features (party, friends, healing)
```

## 🆕 Adding a New Feature

### Step 1: Choose the Right Category

First, decide which category your feature belongs to:

- **UI**: Visual elements, displays, indicators
- **Combat**: Attack, healing, buffs, combat mechanics
- **Utility**: Tools, timers, automation helpers
- **Movement**: Following, pathfinding, teleportation
- **Alarms**: Alerts, notifications, warnings
- **Social**: Party management, friend systems, communication

### Step 2: Create Your Module File

Create a new `.lua` file in the appropriate folder:

```
modules/combat/my_awesome_spell.lua
```

### Step 3: Use the Module Template

Use this template for your module:

```lua
-- =========================================
-- MODULE: My Awesome Spell
-- =========================================
-- Description: What this module does and how it works
--
-- Configuration:
-- - spell: The spell to cast
-- - delay: How often to check
-- - minMana: Minimum mana to cast
--
-- Usage: Enable the macro and configure settings

-- Initialize storage if needed
if not storage.myAwesomeSpell then
    storage.myAwesomeSpell = {
        enabled = false,
        spell = "exori gran",
        delay = 1000,
        minMana = 100
    }
end

-- Create UI elements
UI.Label("My Awesome Spell")

local spellMacro = macro(storage.myAwesomeSpell.delay, "Awesome Spell", function()
    if manapercent() < storage.myAwesomeSpell.minMana then return end
    
    if g_game.isAttacking() then
        say(storage.myAwesomeSpell.spell)
    end
end)

-- Configuration UI
UI.TextEdit(storage.myAwesomeSpell.spell or "exori gran", function(widget, text)
    storage.myAwesomeSpell.spell = text
end)

UI.Separator()
```

### Step 4: Register Your Module

Edit `init.lua` and add your module to the appropriate section:

```lua
-- =========================================
-- COMBAT MODULES (Fighting features)
-- =========================================
dofile("modules/combat/attack.lua")
dofile("modules/combat/healing.lua")
dofile("modules/combat/buff.lua")
dofile("modules/combat/dodge.lua")
dofile("modules/combat/my_awesome_spell.lua")  -- <-- Add here
```

### Step 5: Test Your Module

1. Reload the bot in OTClient
2. Check for any error messages
3. Test your feature in-game
4. Verify it doesn't conflict with other modules

## 📝 Coding Guidelines

### Naming Conventions

- **Files**: Use lowercase with underscores: `my_feature.lua`
- **Functions**: Use camelCase: `myFunction()`
- **Variables**: Use camelCase: `myVariable`
- **Constants**: Use UPPERCASE: `MY_CONSTANT`

### Code Style

```lua
-- Good: Clear spacing and structure
local function checkHealth()
    if player:getHealthPercent() < 50 then
        return true
    end
    return false
end

-- Bad: Cramped and unclear
local function checkHealth()
if player:getHealthPercent()<50 then return true end return false end
```

### Comments

Add comments for:
- Complex logic
- Configuration options
- Important behavior
- Known limitations

```lua
-- Check if player is in house bounds
-- Note: Z-level must match exactly
local function isInsideHouse()
    local p = pos()
    return p.z == config.house.z 
       and p.x >= config.house.x1 
       and p.x <= config.house.x2
end
```

### Storage Management

Always initialize storage with defaults:

```lua
-- Good: Safe initialization
if not storage.myFeature then
    storage.myFeature = {
        enabled = false,
        value = 100
    }
end

-- Bad: Can cause errors if storage doesn't exist
storage.myFeature.value = 100
```

## 🔧 Using Configuration Files

If your feature needs configuration, add it to `config/settings.lua`:

```lua
-- In config/settings.lua
config.myFeature = {
    delay = 1000,
    range = 5,
    itemId = 3031
}

-- In your module
-- CONFIG is globally available (loaded by init.lua)
local myConfig = CONFIG.myFeature

macro(myConfig.delay, "My Feature", function()
    -- Use myConfig.range, myConfig.itemId, etc.
end)
```

**Note**: CONFIG is loaded globally by `init.lua`, so you don't need to use `dofile()` in your modules.

## 🎨 Creating UI Elements

### Common UI Components

```lua
-- Label
UI.Label("My Label Text")

-- Text Input
UI.TextEdit(storage.text or "default", function(widget, newText)
    storage.text = newText
end)

-- Button
UI.Button("Click Me", function()
    print("Button clicked!")
end)

-- Separator (visual divider)
UI.Separator()

-- Switch/Toggle
addSwitch("mySwitch", "Toggle Feature", function(widget)
    myFeature.enabled = not myFeature.enabled
    widget:setOn(myFeature.enabled)
end)
```

## 🐛 Debugging Tips

### Print Debugging

```lua
macro(1000, function()
    local hp = player:getHealthPercent()
    print("Current HP: " .. hp)  -- Appears in console
end)
```

### Check for Nil Values

```lua
local function safeFunction()
    local player = g_game.getLocalPlayer()
    if not player then 
        print("Player not found!")
        return 
    end
    
    -- Safe to use player now
    local pos = player:getPosition()
end
```

### Error Handling

```lua
local status, result = pcall(function()
    -- Code that might error
    riskyOperation()
end)

if not status then
    print("Error: " .. result)
end
```

## 📚 Common Functions Reference

### Player Functions
```lua
player:getHealthPercent()
player:getManaPercent()
player:getPosition()
player:isWalking()
pos()  -- Current position
hppercent()  -- HP percentage
manapercent()  -- Mana percentage
```

### Game Functions
```lua
g_game.isOnline()
g_game.isAttacking()
g_game.getAttackingCreature()
g_game.use(item)
g_game.useWith(item, target)
```

### Items
```lua
findItem(itemId)  -- Find item in inventory
itemAmount(itemId)  -- Count items
getContainers()  -- Get all containers
```

### Distance/Position
```lua
getDistanceBetween(pos1, pos2)
autoWalk(targetPos, maxDistance, options)
```

## ✅ Checklist Before Submitting

- [ ] Code follows the project structure
- [ ] Module is in the correct category folder
- [ ] Module is registered in `init.lua`
- [ ] Code has helpful comments
- [ ] Storage is properly initialized
- [ ] UI elements have separators
- [ ] Tested in-game without errors
- [ ] Doesn't conflict with other modules
- [ ] Configuration is in `config/settings.lua` if needed

## 💡 Example: Complete Feature

Here's a complete example of adding a mana shield feature:

**File: `modules/combat/mana_shield.lua`**

```lua
-- =========================================
-- MODULE: Auto Mana Shield
-- =========================================
-- Automatically casts mana shield when buff is missing

if not storage.manaShield then
    storage.manaShield = {
        spell = "utamo vita",
        checkInterval = 1000
    }
end

UI.Label("Mana Shield")

local shieldMacro = macro(storage.manaShield.checkInterval, "Auto Mana Shield", function()
    -- Check if player has mana shield buff
    -- (Implementation depends on how your server shows buffs)
    if not hasManaBuff() and manapercent() > 20 then
        say(storage.manaShield.spell)
    end
end)

UI.TextEdit(storage.manaShield.spell or "utamo vita", function(widget, text)
    storage.manaShield.spell = text
end)

UI.Separator()
```

**Update `init.lua`:**
```lua
dofile("modules/combat/mana_shield.lua")
```

## 🤝 Getting Help

If you need help:
1. Check existing modules for examples
2. Read the function reference in `lib/vlib.lua`
3. Test with print statements
4. Ask in the community

Happy coding! 🚀
