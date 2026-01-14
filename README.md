# Marcsz Auto Bot

A modular automation system for OTClient with an organized, easy-to-understand structure.

## 📁 Project Structure

```
MarcszAUTO/
├── init.lua                 # Main entry point - loads all modules
├── config/                  # Configuration files
│   └── settings.lua         # Global settings and configurations
├── modules/                 # Feature modules (organized by category)
│   ├── ui/                  # User interface components
│   │   ├── rainbow_title.lua    # Rainbow glitch title effect
│   │   └── position_display.lua # Position display widget
│   ├── combat/              # Combat-related features
│   │   ├── attack.lua           # Attack macros and spells
│   │   ├── healing.lua          # Self-healing system
│   │   ├── buff.lua             # Buff management
│   │   └── dodge.lua            # Boss dodge mechanics
│   ├── utility/             # Utility functions and helpers
│   │   ├── boss_timer.lua       # Boss raid timer
│   │   ├── house_trainer.lua    # Training dummy automation
│   │   ├── money_converter.lua  # Auto money stacking
│   │   ├── auto_bless.lua       # Auto bless on death/relog
│   │   └── helpers.lua          # Shared utility functions
│   ├── movement/            # Movement and following
│   │   ├── turbo_follow.lua     # Advanced follow system
│   │   └── follow_basic.lua     # Basic follow with attack
│   ├── alarms/              # Alert and alarm systems
│   │   └── alarm_system.lua     # HP/Mana/Player detection alarms
│   └── social/              # Social features
│       ├── friend_healer.lua    # Heal party members
│       └── player_list.lua      # Friend/enemy list management
├── lib/                     # Shared libraries
│   └── vlib.lua             # Core utility functions
└── Alarme/                  # Sound files for alarms
```

## 🚀 Getting Started

1. Copy the `MarcszAUTO` folder to your OTClient bot directory
2. Load the bot configuration in OTClient
3. All features will load automatically from `init.lua`

## ✨ Features

### UI Features
- **Rainbow Title**: Animated rainbow text with glitch effects
- **Position Display**: Real-time coordinate display

### Combat Features
- **Attack System**: Auto-attack with multiple spells
- **Healing System**: Configurable HP-based healing with potions and spells
- **Buff System**: Auto-buff management
- **Dodge Logic**: Smart boss mechanic dodging
- **HP Display**: Show monster HP percentage

### Utility Features
- **Boss Timer**: Countdown timer for boss raids with alarms
- **House Trainer**: Auto-attack training dummies
- **Money Converter**: Auto-stack gold coins
- **Auto Bless**: Automatic blessing on death/relog
- **Auto Sell/Deposit**: Automated item management
- **Anti-Push**: Drop items to prevent pushing

### Movement Features
- **Turbo Follow**: Advanced following with portal detection
- **Follow Attack**: Follow player and attack targets
- **Auto-Follow Target**: Sense and follow attack target

### Social Features
- **Friend Healer**: Heal party members (SIO system)
- **Player Lists**: Manage friends and enemies
- **Auto Party**: Auto-accept party invites

### Alarms & Alerts
- **HP/Mana Alarms**: Alerts when resources are low
- **Player Detection**: Alert when players are nearby
- **Attack Alarms**: Notify when being attacked
- **Private Message Alerts**: Sound notification for PMs

## 📝 Adding New Scripts

To add a new feature:

1. **Create a new file** in the appropriate module folder:
   ```
   modules/combat/my_new_feature.lua
   ```

2. **Write your feature** using this template:
   ```lua
   -- modules/combat/my_new_feature.lua
   -- Description: What this module does
   
   local config = {
       setting1 = value1,
       setting2 = value2
   }
   
   macro(1000, "My Feature Name", function()
       -- Your code here
   end)
   ```

3. **Register in init.lua**:
   ```lua
   dofile("modules/combat/my_new_feature.lua")
   ```

4. The module will load automatically on next bot reload

## 🔧 Configuration

Edit `config/settings.lua` to customize global settings like:
- Default spell delays
- House coordinates
- Boss raid times
- Item IDs

## 📖 Module Documentation

Each module is self-contained and documented with:
- **Purpose**: What the module does
- **Configuration**: Available settings
- **Usage**: How to use the feature
- **Dependencies**: Required libraries or other modules

## 🤝 Contributing

To contribute:
1. Create your feature in the appropriate module folder
2. Follow the existing code style
3. Add comments explaining complex logic
4. Test thoroughly before committing

## 📄 License

Free to use and modify.

## 👤 Author

@Marcsz - Original creator
Refactored for modularity and ease of use.
