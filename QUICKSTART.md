# RoBoost Quick Start Guide

Get started with RoBoost in just a few minutes!

## 📥 Installation

### Step 1: System Requirements

- **OS:** Windows 10 or Windows 11 (64-bit recommended)
- **Runtime:** .NET 6 Desktop Runtime
- **Disk Space:** 200MB minimum
- **RAM:** 512MB minimum

### Step 2: Download

1. Go to [GitHub Releases](https://github.com/Rloxx/RoBoost/releases)
2. Download the latest `RoBoost-*.exe` file
3. Run the installer

### Step 3: Install .NET (if needed)

If your system is missing .NET 6 Desktop Runtime:

- RoBoost will prompt you to install it
- Download from: https://aka.ms/dotnet-core-applaunch
- Install and restart if prompted

### Step 4: Launch RoBoost

1. Find RoBoost in your Start Menu
2. Click to launch RoBoost launcher
3. You're ready to go!

## 🎮 Playing Roblox

### First-Time Setup

1. **Open RoBoost** from your Start Menu
2. **Click "Play Roblox"** to launch the game
3. Configure any settings you want (optional)
4. **Join a game** through your Roblox account

### Main Window

- **Play Roblox Button** - Launch Roblox Player
- **Open Studio Button** - Launch Roblox Studio
- **Settings** - Customize RoBoost and Roblox settings
- **System Tray** - Minimize and access RoBoost from taskbar

### New Control Center Tabs

RoBoost now includes expanded settings navigation with additional pages:

- **Performance Lab** - Quick performance tuning presets and optimization toggles
- **Quick Tools** - One-click folder access, cache cleaning, and settings backup
- **Session Profiles** - Manage profile presets for different play styles
- **Creator Credits** - In-app project credits and links
- **Core** - Main RoBoost behavior and export options

## ⚙️ Essential Settings

### Enable FastFlags (Recommended)

1. Open **Settings**
2. Go to **FastFlags** tab
3. Toggle **"Enable FastFlag Manager"** ON
4. Restart Roblox to apply changes

### Configure Graphics (Optional)

1. Open **Settings**
2. Go to **FastFlags** → **Rendering**
3. Select your preferred rendering mode:
   - **D3D11** - Modern systems, better performance
   - **D3D10** - Older/compatibility systems
4. Adjust MSAA and Texture Quality to taste

### Remove Textures

1. Open **Settings**
2. Go to **FastFlags**
3. Enable **Remove Textures**
4. Choose one:
   - **Method 1 (removing from file)**
   - **Method 2 (FFlag)**
5. If one method does not work, use the other method

### Set Discord Rich Presence (Optional)

1. Open **Settings**
2. Go to **Discord** or **Integrations** tab
3. Toggle **Discord Rich Presence** ON
4. Your Discord friends will see what you're playing

## 🚀 FastFlags - Power User Mode

### What are FastFlags?

FastFlags are hidden Roblox settings that control rendering, performance, and experimental features.

### Using FastFlag Presets (Easiest)

1. Launch RoBoost → **Settings**
2. Click **FastFlags** tab
3. Use dropdown menus to select:
   - **Rendering Mode** (D3D11/D3D10)
   - **MSAA Level** (Anti-aliasing quality)
   - **Texture Quality** (Visual fidelity)
4. Changes apply automatically

### Manual FastFlag Editor (Advanced)

1. In FastFlags settings, click **"Open Flag Editor"**
2. Edit JSON flags directly
3. Common FastFlags:
   ```json
   {
     "FFlagDebugGraphicsPreferD3D11": "true",
     "FIntDebugForceMSAASamples": "4",
     "DFFlagDisableDPIScale": "true"
   }
   ```
4. Save and restart Roblox

### Recommended FastFlag Presets

- **Good Performance:** D3D11, 1x MSAA, Low Texture Quality
- **Balanced:** D3D11, 2x MSAA, Medium Texture Quality
- **High Quality:** D3D11, 4x MSAA, High Texture Quality
- **Older PC:** D3D10, 1x MSAA, Low Texture Quality

## 📝 Add mods/Customizations

### Install a Mod

1. Download a mod (usually a `.xml` or folder)
2. Open RoBoost **Settings**
3. Go to **Mods** tab
4. Click **"Add Mod"**
5. Select the mod file/folder
6. Restart RoBoost

### Common Mods

- **Death Sound** - Customize death notification sound
- **Cursor** - Replace Roblox cursor with custom image
- **UI Skinning** - Change UI appearance

## 🎯 Game History & Favorites

### View Recent Games

1. Click **History** in RoBoost main window
2. See all recently played games
3. Click any game to **Quick Join**

### Mark as Favorite

1. In History, right-click a game
2. Select **"Add to Favorites"**
3. Quick access from Favorites list

## 🔧 Troubleshooting

### Roblox Won't Launch?

- Restart RoBoost
- Check if Roblox Player/Studio is installed
- Verify your internet connection
- Run RoBoost as Administrator

### Performance Issues?

- Open **Settings** → **FastFlags**
- Switch to lower texture quality
- Disable unnecessary mods
- Reduce MSAA settings

### Settings Won't Save?

- Run RoBoost as Administrator
- Check disk space
- Verify AppData folder permissions
- Restart your computer

### Mods Not Working?

- Ensure mod is compatible with your Roblox version
- Disable other conflicting mods
- Check mod installation folder
- Re-install the problematic mod

## 📚 Need Help?

- **GitHub Issues:** https://github.com/Rloxx/RoBoost/issues
- **GitHub Discussions:** https://github.com/Rloxx/RoBoost/discussions
- **Wiki:** https://github.com/Rloxx/RoBoost/wiki

## 🎮 Pro Tips

1. **Use Different Profiles** - Save settings per-game using command-line arguments
2. **Monitor Performance** - Check FPS counter (if enabled in Roblox settings)
3. **Backup Mods** - Export your mod list before major updates
4. **Keep Updated** - Enable auto-updates for latest features and fixes
5. **Try FastFlags** - Experiment with different rendering modes for your setup
6. **Use Quick Tools Weekly** - Clean temp cache to keep update operations smooth
7. **Use Session Profiles** - Keep one profile for competitive and one for visuals

## ⚡ Keyboard Shortcuts

| Shortcut | Action            |
| -------- | ----------------- |
| `Ctrl+,` | Open Settings     |
| `Ctrl+Q` | Quit RoBoost      |
| `Ctrl+H` | Show Game History |
| `Ctrl+R` | Refresh/Reload    |

---

**Enjoy RoBoost!** 🚀

Questions? Check the [full documentation](https://github.com/Rloxx/RoBoost/wiki) or open an issue on GitHub.

**Made by Rloxx**
