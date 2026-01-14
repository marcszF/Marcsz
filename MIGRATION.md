# Migration Guide: Old → New Structure

## Overview

The project has been completely refactored for better organization and ease of use. Here's what changed:

## What Changed?

### Old Structure (Messy)
```
MarcszAUTO/
├── 0_AAmain.lua          (2KB - UI effects)
├── _main.lua             (23KB - EVERYTHING mixed together)
├── _vlib.lua             (15KB - utility functions)
├── 1_alarms.lua          (7KB - alarms)
├── 3_Sio.lua             (4KB - friend healer)
├── 3_player_list.lua     (2KB - player lists)
├── tools.lua             (2KB - misc tools)
├── tools2.lua            (3KB - more misc tools)
├── spy_level.lua         (0.5KB - level spy)
└── MzBugmap.lua          (1KB - bug map)
```

### New Structure (Organized)
```
MarcszAUTO/
├── init.lua                      # Main loader (loads everything)
├── config/
│   └── settings.lua              # All configuration in one place
├── modules/
│   ├── ui/                       # Visual elements
│   │   ├── rainbow_title.lua
│   │   └── position_display.lua
│   ├── combat/                   # Combat features
│   │   ├── attack.lua
│   │   ├── healing.lua
│   │   ├── buff.lua
│   │   └── dodge.lua
│   ├── utility/                  # Tools & helpers
│   │   ├── boss_timer.lua
│   │   ├── house_trainer.lua
│   │   ├── money_converter.lua
│   │   ├── auto_utilities.lua
│   │   ├── general_utils.lua
│   │   ├── spy_level.lua
│   │   └── bug_map.lua
│   ├── movement/                 # Following & navigation
│   │   ├── turbo_follow.lua
│   │   ├── follow_basic.lua
│   │   └── anti_push.lua
│   ├── alarms/                   # Alert systems
│   │   └── alarm_system.lua
│   └── social/                   # Party & friends
│       ├── friend_healer.lua
│       ├── player_list.lua
│       └── auto_party.lua
└── lib/
    └── vlib.lua                  # Shared utility functions
```

## Feature Location Mapping

If you're looking for a specific feature, here's where it moved:

| Old File | Feature | New Location |
|----------|---------|--------------|
| 0_AAmain.lua | Rainbow title effect | `modules/ui/rainbow_title.lua` |
| _main.lua | Boss timer | `modules/utility/boss_timer.lua` |
| _main.lua | HP display | `modules/combat/attack.lua` |
| _main.lua | Attack spells | `modules/combat/attack.lua` |
| _main.lua | Healing system | `modules/combat/healing.lua` |
| _main.lua | Buff system | `modules/combat/buff.lua` |
| _main.lua | Dodge logic | `modules/combat/dodge.lua` |
| _main.lua | House trainer | `modules/utility/house_trainer.lua` |
| _main.lua | Money converter | `modules/utility/money_converter.lua` |
| _main.lua | Auto utilities | `modules/utility/auto_utilities.lua` |
| _main.lua | Turbo follow | `modules/movement/turbo_follow.lua` |
| 1_alarms.lua | Alarm system | `modules/alarms/alarm_system.lua` |
| 3_Sio.lua | Friend healer | `modules/social/friend_healer.lua` |
| 3_player_list.lua | Player lists | `modules/social/player_list.lua` |
| tools.lua | Position display | `modules/ui/position_display.lua` |
| tools.lua | General utilities | `modules/utility/general_utils.lua` |
| tools2.lua | Follow systems | `modules/movement/follow_basic.lua` |
| tools2.lua | Anti-push | `modules/movement/anti_push.lua` |
| spy_level.lua | Spy level | `modules/utility/spy_level.lua` |
| MzBugmap.lua | Bug map | `modules/utility/bug_map.lua` |
| _vlib.lua | Utility functions | `lib/vlib.lua` |

## How to Use the New Structure

### Option 1: Fresh Start (Recommended)

1. **Backup your old files** (just in case)
2. **Use the new structure** - Everything is already organized
3. **Edit `config/settings.lua`** to customize your settings
4. **Load `init.lua`** in OTClient

### Option 2: Keep Old Files (Not Recommended)

You can keep the old files if needed, but you'll lose the benefits of the new structure:
- Harder to find features
- Harder to add new scripts
- Harder to maintain
- Duplicated code

## Configuration Changes

### Old Way (Scattered)
Configuration was spread across multiple files:
```lua
-- In _main.lua line 6
local bossConfig = {
    alarmSeconds = 60,
    sound = "AlarmClock.wav"
}

-- In _main.lua line 139
local trainerConfig = {
    house = { x1 = 1051, y1 = 1040, ... }
}

-- And so on...
```

### New Way (Centralized)
All configuration is in one file: `config/settings.lua`
```lua
local config = {}

config.boss = {
    alarmSeconds = 60,
    sound = "AlarmClock.wav",
    raidHours = { "01:30", "03:30", ... }
}

config.trainer = {
    house = { x1 = 1051, y1 = 1040, ... },
    wands = {55486, 55484, 55634}
}

return config
```

**To change settings:** Just edit `config/settings.lua`

## Adding New Features

### Old Way
```
1. Open _main.lua (23KB file)
2. Scroll through 690 lines
3. Find a good spot
4. Add your code
5. Hope it doesn't break anything
6. Repeat for every new feature
```

### New Way
```
1. Create modules/combat/my_feature.lua
2. Write your feature
3. Add one line to init.lua:
   dofile("modules/combat/my_feature.lua")
4. Done! ✅
```

See `CONTRIBUTING.md` for detailed instructions.

## What Stays the Same?

- **All functionality**: Every feature still works exactly as before
- **Storage**: Your saved settings are preserved
- **UI files**: .otui files are still in the same locations
- **Sound files**: Alarme/ folder is unchanged
- **Your data**: No data loss, everything is backwards compatible

## Benefits of New Structure

### 1. Easy to Understand
```
Need healing? → modules/combat/healing.lua
Need following? → modules/movement/turbo_follow.lua
Need alarms? → modules/alarms/alarm_system.lua
```

### 2. Easy to Modify
Each file is small and focused:
- `rainbow_title.lua`: 95 lines
- `attack.lua`: 60 lines
- `healing.lua`: 50 lines

Compare to old `_main.lua`: 690 lines of mixed code!

### 3. Easy to Extend
Want to add a new spell? Just create:
```
modules/combat/my_awesome_spell.lua
```

### 4. Better Documentation
Every module has:
- Clear description
- Configuration explained
- Usage instructions
- Inline comments

### 5. Fewer Conflicts
Separate files = less merge conflicts = easier teamwork

## Troubleshooting

### "I can't find X feature"
Check the mapping table above or search in the new structure:
```bash
grep -r "feature name" modules/
```

### "Something isn't working"
1. Check if `init.lua` is loading all modules
2. Look for error messages in the console
3. Verify paths in `init.lua` match your file structure
4. Check `config/settings.lua` for correct values

### "I want to disable a feature"
Just comment out the line in `init.lua`:
```lua
-- dofile("modules/combat/dodge.lua")  -- Disabled
```

### "I made changes but they're not working"
Make sure to reload the bot after editing files.

## Questions?

- Read `README.md` for feature documentation
- Read `CONTRIBUTING.md` for development guide
- Check individual module files for inline documentation

## Summary

| Aspect | Old | New |
|--------|-----|-----|
| Files | 10+ scattered files | Organized in folders |
| Largest file | 690 lines | ~300 lines max |
| Configuration | Scattered everywhere | One file: `config/settings.lua` |
| Adding features | Edit huge file | Create new small file |
| Finding code | Search through 690 lines | Go to right folder |
| Documentation | Minimal | README + CONTRIBUTING + inline |
| Maintainability | Hard | Easy |

**Bottom line:** The new structure is much better for everyone! 🎉
