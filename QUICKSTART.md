# Quick Start Guide

Get up and running with Marcsz Auto in 5 minutes!

## 📦 Installation

1. **Download** or clone this repository
2. **Copy** the `MarcszAUTO` folder to your OTClient bot directory
3. **Configure** your bot in OTClient to load from this directory

## ⚡ First Launch

When you first launch the bot:

1. Open OTClient
2. Go to Bot settings
3. Select the `MarcszAUTO` configuration
4. Load the bot

You should see: `"Marcsz Auto - Loaded Successfully!"`

## 🎮 Essential Features to Enable First

### 1. Healing (Keep Yourself Alive)
Located in the bot panel:
- **"HP%"**: Configure your healing spell and HP thresholds
- **Health Item**: Set up potion healing

### 2. Attack (Combat)
- **"Attack"**: Enable multi-spell attack
- Configure your spells in the text boxes
- **"Atacar Seguindo"**: Auto-chase enemies

### 3. Boss Timer
- Automatic countdown to boss raids
- Plays alarm before boss spawns
- Icon shows time remaining

### 4. Alarms (Safety)
Click **"Edite"** on the Alarm panel to configure:
- HP/Mana alerts
- Player detection (PvP warning)
- Auto-logout option

## ⚙️ Configuration

### Quick Settings

Edit `config/settings.lua` to customize:

```lua
-- Boss raid times
config.boss.raidHours = {
    "01:30", "03:30", "05:30", "07:30", "09:30", "11:30",
    "13:30", "15:30", "17:30", "19:30", "21:30", "23:30"
}

-- Your house coordinates (for trainer)
config.trainer.house = {
    x1 = 1051, y1 = 1040,
    x2 = 1057, y2 = 1044,
    z = 7
}
```

## 🎯 Common Use Cases

### Solo Hunting
Enable:
- ✅ Attack system
- ✅ HP/Mana healing
- ✅ Buff system
- ✅ Monster HP display

### Team Hunting
Enable everything above, plus:
- ✅ Friend Healer (SIO)
- ✅ Player List (add friends)
- ✅ Follow system

### Training
Enable:
- ✅ House Trainer
- Configure your house coordinates in `config/settings.lua`

### Boss Raids
Enable:
- ✅ Boss Timer
- ✅ Dodge Logic (if boss has mechanics)
- ✅ All combat features

### AFK/Safety
Enable:
- ✅ All alarms
- ✅ Player detection with auto-logout
- ✅ HP/Mana alarms

## 🔧 Customization

### Change Hotkeys

Most macros have default hotkeys. To change them:

1. Find the macro in the code (e.g., `modules/combat/attack.lua`)
2. Change the hotkey string:
   ```lua
   macro(250, "Atacar Seguindo", "Shift+R", function()
   -- Change "Shift+R" to your preferred key
   ```

### Add Custom Spells

Edit the spell text fields in-game, or modify the defaults in code:
```lua
storage.magia1 = "exori gran"
storage.magia2 = "exori"
storage.magia3 = "exori hur"
```

### Adjust Timings

In `config/settings.lua`:
```lua
config.trainer.delay = 1500  -- Training attack delay
config.dodge.returnDelay = 500  -- Dodge return time
config.follow.checkInterval = 50  -- Follow update speed
```

## 📱 UI Layout

```
┌─────────────────────────────┐
│ Marcsz (Rainbow Title)      │
├─────────────────────────────┤
│ Player Position: X/Y/Z      │
├─────────────────────────────┤
│ ⏰ Boss Timer (Icon)         │
├─────────────────────────────┤
│ 🎯 Attack Controls          │
│   [Spell 1]                 │
│   [Spell 2]                 │
│   [Spell 3]                 │
├─────────────────────────────┤
│ ❤️ Healing System           │
│   HP: [___] %               │
├─────────────────────────────┤
│ 💪 Buff System              │
│   [utito tempo san]         │
├─────────────────────────────┤
│ 🚶 Movement                  │
│   [Follow Name]             │
├─────────────────────────────┤
│ 🔔 Alarms [Edite]           │
├─────────────────────────────┤
│ 👥 Friend Healer [Edite]    │
└─────────────────────────────┘
```

## 🎨 Icons

Several features create draggable icons on your screen:

- **Boss Timer**: Shows countdown to next raid
- **House Trainer**: Toggle training on/off

You can drag these icons anywhere on your screen.

## 💾 Saving Settings

All your settings are automatically saved in OTClient's storage system:
- Spell configurations
- HP/Mana thresholds
- Friend lists
- Alarm settings
- Everything else!

No manual saving required.

## 🐛 Troubleshooting

### Bot won't load
- Check OTClient console for error messages
- Verify all files are in the correct locations
- Make sure `init.lua` is the entry point

### Feature not working
1. Check if it's enabled (green button/checkbox)
2. Verify configuration settings
3. Look for error messages in console
4. Check if you meet the requirements (e.g., enough mana)

### Want to disable a feature
Comment out the line in `init.lua`:
```lua
-- dofile("modules/combat/dodge.lua")  -- Disabled
```

Then reload the bot.

## 📚 Learn More

- **README.md**: Full feature documentation
- **CONTRIBUTING.md**: How to add your own features
- **MIGRATION.md**: Transition guide from old structure
- **config/settings.lua**: All configuration options

## 🎓 Tutorial: Your First Custom Feature

Let's add a simple mana training spell:

1. Create `modules/combat/mana_training.lua`:
```lua
-- Auto-cast utana vid when training mana
macro(1000, "Mana Training", function()
    if manapercent() < 100 then
        say("utana vid")
    end
end)

UI.Separator()
```

2. Register it in `init.lua`:
```lua
dofile("modules/combat/mana_training.lua")
```

3. Reload bot

4. Enable "Mana Training" in the bot panel

Done! You've created your first feature! 🎉

## 🚀 Next Steps

1. **Explore** all the features in the bot panel
2. **Customize** settings in `config/settings.lua`
3. **Read** CONTRIBUTING.md to learn how to add features
4. **Experiment** with different configurations

## ❓ Need Help?

- Check the inline comments in module files
- Read the documentation files
- Look at existing modules for examples

Happy botting! 🎮
