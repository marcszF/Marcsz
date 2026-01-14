# 📚 Documentation Index

Welcome to Marcsz Auto! This page helps you find the right documentation.

## 🎯 I Want To...

### Get Started
👉 **[QUICKSTART.md](QUICKSTART.md)** - Get up and running in 5 minutes

### Understand the Project
👉 **[README.md](README.md)** - Complete feature list and project overview

### Migrate from Old Version
👉 **[MIGRATION.md](MIGRATION.md)** - Transition guide from old structure

### Add New Features
👉 **[CONTRIBUTING.md](CONTRIBUTING.md)** - Developer guide with examples

### Configure Settings
👉 **[config/settings.lua](MarcszAUTO/config/settings.lua)** - All configuration options

## 📖 Documentation Files

### For Users

| File | Description | When to Read |
|------|-------------|--------------|
| **QUICKSTART.md** | Quick setup guide | First time using the bot |
| **README.md** | Feature documentation | Want to know what features exist |
| **MIGRATION.md** | Upgrade guide | Upgrading from old version |

### For Developers

| File | Description | When to Read |
|------|-------------|--------------|
| **CONTRIBUTING.md** | How to add features | Want to customize or add features |
| **init.lua** | Module loader | Want to see how modules are loaded |
| **config/settings.lua** | Configuration | Need to change settings |

### Module Documentation

Each module file contains inline documentation:

```lua
-- =========================================
-- MODULE: [Name]
-- =========================================
-- Description: What this does
-- Configuration: Settings available
-- Usage: How to use
```

## 🗂️ File Structure Reference

```
Marcsz/
├── 📄 README.md              # Project overview
├── 📄 QUICKSTART.md          # Quick start guide
├── 📄 MIGRATION.md           # Migration guide
├── 📄 CONTRIBUTING.md        # Developer guide
├── 📄 DOCS.md                # This file
│
└── MarcszAUTO/
    ├── 📄 init.lua           # Main loader (start here)
    │
    ├── 📁 config/
    │   └── settings.lua      # All settings
    │
    ├── 📁 modules/
    │   ├── 📁 ui/            # Visual elements
    │   ├── 📁 combat/        # Fighting features
    │   ├── 📁 utility/       # Tools & helpers
    │   ├── 📁 movement/      # Follow & navigation
    │   ├── 📁 alarms/        # Alert systems
    │   └── 📁 social/        # Party & friends
    │
    ├── 📁 lib/
    │   └── vlib.lua          # Shared utilities
    │
    └── 📁 Alarme/            # Sound files
```

## 🎓 Learning Path

### Beginner
1. Read **QUICKSTART.md** (5 min)
2. Install and test the bot
3. Skim **README.md** to see available features
4. Configure basic settings in **config/settings.lua**

### Intermediate
1. Read full **README.md** (10 min)
2. Explore all features in-game
3. Customize settings for your playstyle
4. Read **MIGRATION.md** if upgrading

### Advanced
1. Read **CONTRIBUTING.md** (15 min)
2. Study existing modules in `modules/`
3. Create your first custom module
4. Explore `lib/vlib.lua` for helper functions

## 🔍 Finding Specific Information

### "Where is feature X?"
Check **MIGRATION.md** - Feature Location Mapping section

### "How do I configure X?"
1. Check **config/settings.lua** for global settings
2. Check the specific module file for that feature
3. Look at **README.md** - Configuration section

### "How do I add feature Y?"
1. Read **CONTRIBUTING.md** - Adding New Features section
2. Look at similar existing modules as examples
3. Follow the module template

### "Something's not working"
1. Check **QUICKSTART.md** - Troubleshooting section
2. Look at console for error messages
3. Verify configuration in **config/settings.lua**

### "How does X work internally?"
1. Find the module in `modules/` folder
2. Read the inline comments
3. Check **lib/vlib.lua** for helper functions

## 📋 Common Tasks

| Task | File to Edit | Documentation |
|------|--------------|---------------|
| Change boss raid times | config/settings.lua | README.md Features |
| Add custom spell | modules/combat/*.lua | CONTRIBUTING.md |
| Adjust healing thresholds | In-game or module file | QUICKSTART.md |
| Change house coordinates | config/settings.lua | README.md Features |
| Disable a feature | init.lua (comment line) | QUICKSTART.md Troubleshooting |
| Add friend to list | In-game or module file | QUICKSTART.md |

## 💡 Tips

### Reading Code
- Start with `init.lua` to see the loading order
- Each module is self-contained and documented
- Helper functions are in `lib/vlib.lua`

### Making Changes
- Always backup before editing
- Test one change at a time
- Use the console to see errors
- Comment out features to debug issues

### Getting Help
- Error messages point to file and line number
- Use `print()` for debugging
- Check existing similar modules for examples

## 🌟 Best Practices

1. **Read QUICKSTART first** - Get familiar with the basics
2. **Backup your changes** - Before editing, save a copy
3. **Test incrementally** - Change one thing, test it
4. **Use comments** - Document your custom code
5. **Follow the structure** - Keep modules in right folders

## 📞 Support Resources

- **Inline docs**: Every module file has comments
- **Example code**: Look at existing modules
- **Templates**: CONTRIBUTING.md has templates
- **Console**: Error messages show what's wrong

## 🎯 Quick Reference

### Essential Files
- `init.lua` - Loads everything
- `config/settings.lua` - All settings
- `README.md` - What features exist
- `CONTRIBUTING.md` - How to add features

### Essential Folders
- `modules/combat/` - Fighting features
- `modules/utility/` - Tools and helpers
- `modules/movement/` - Follow systems
- `config/` - Settings

### Essential Commands
- Reload bot after changes
- Check console for errors
- Comment lines with `--`
- Use `print()` for debugging

## 🔗 Documentation Links

- [Main README](README.md) - Start here for overview
- [Quick Start](QUICKSTART.md) - Get started fast
- [Contributing](CONTRIBUTING.md) - Add features
- [Migration](MIGRATION.md) - Upgrade guide
- [Settings](MarcszAUTO/config/settings.lua) - Configuration

---

**Need help?** Pick the right documentation file above and start reading! 📖
