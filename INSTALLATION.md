# RoBoost Installation Guide

Complete installation instructions for RoBoost on Windows.

## 🖥️ System Requirements

### Minimum Requirements

- **OS:** Windows 10 (build 18363) or newer
- **Architecture:** 64-bit system (32-bit support not guaranteed)
- **RAM:** 512 MB minimum
- **Disk Space:** 200 MB for RoBoost installation
- **Runtime:** .NET 6 Desktop Runtime (auto-installed if missing)
- **Internet:** Required for Roblox online features

### Recommended

- **OS:** Windows 11 (latest version)
- **Architecture:** 64-bit
- **RAM:** 4 GB or more
- **Disk Space:** 500 MB (includes Roblox and mods)
- **Internet:** Stable broadband connection
- **GPU:** NVIDIA/AMD dedicated graphics for optimal FastFlags

## 📋 Pre-Installation Checklist

Before installing RoBoost:

- ✅ Backup any existing Roblox settings or mods
- ✅ Ensure Windows is updated to latest version
- ✅ Close any running Roblox processes
- ✅ Disable any antivirus real-time scanning temporarily (if needed)
- ✅ Verify adequate disk space
- ✅ Note your Roblox username (optional)

## 💾 Installation Methods

### Method 1: Standard Installer (Recommended)

1. **Download RoBoost**
   - Visit: https://github.com/Rloxx/RoBoost/releases
   - Download `RoBoost-[version].exe`
   - File size: ~10-15 MB

2. **Run the Installer**
   - Double-click `RoBoost-[version].exe`
   - Windows SmartScreen may appear
   - Click **"More info"** → **"Run anyway"** (this is normal for unsigned executables)
   - Click **"Yes"** on User Account Control (UAC) prompt

3. **Follow Installer Steps**
   - Accept the license agreement
   - Choose installation location (default: `C:\Users\[YourName]\AppData\Local\RoBoost`)
   - Click **"Install"**
   - Wait for installation to complete

4. **Install .NET Runtime (if prompted)**
   - If you don't have .NET 6 Desktop Runtime:
   - Click **"Install .NET Runtime"**
   - Follow Microsoft's installation wizard
   - Restart when prompted
   - Run RoBoost installer again

5. **Verify Installation**
   - Look for **RoBoost** in your Start Menu
   - Click to launch and verify it opens correctly
   - If prompted to update, update now

### Method 2: Portable Installation

If you prefer a portable version without system installation:

1. Download the portable ZIP file (if available)
2. Extract to your desired folder
3. Run `RoBoost.exe` from the extracted folder
4. No additional installation steps needed
5. Settings will be saved locally in the same folder

### Method 3: Building from Source

For developers who want to build RoBoost:

**Prerequisites:**

- Visual Studio 2022 (any edition)
- .NET 6 SDK
- Git

**Steps:**

```bash
# Clone the repository
git clone https://github.com/Rloxx/RoBoost.git
cd RoBoost

# Build the solution
dotnet build RoBoost.sln

# Run the application
dotnet run --project RoBoost/RoBoost.csproj
```

## 🔧 Post-Installation Setup

### 1. Initial Launch

1. Launch RoBoost from Start Menu
2. Allow Windows Firewall access (if prompted)
3. RoBoost will auto-detect your Roblox installation
4. If Roblox not detected, install it first from Roblox.com

### 2. Configure Basic Settings

1. Click **Settings** in RoBoost
2. Adjust the following:
   - **Theme:** Light or Dark mode
   - **Language:** Select your language
   - **Startup:** Choose to launch Roblox on startup (optional)
   - **Logging:** Enable for debugging (optional)

### 3. Set Up FastFlags (Recommended)

1. Go to **Settings** → **FastFlags**
2. Toggle **"Enable FastFlag Manager"** ON
3. Choose your rendering mode:
   - **D3D11** - Modern systems
   - **D3D10** - Older systems
4. Set MSAA and Texture Quality to your preference
5. Click **Save**

### 4. Connect Discord (Optional)

1. Go to **Settings** → **Discord**
2. Toggle **"Enable Discord Rich Presence"** ON
3. Authorize RoBoost to access Discord
4. Friends will now see what you're playing

## 🚀 First Launch

### Starting RoBoost

**From Start Menu:**

- Windows 11: Press `Win` key, type "RoBoost", press Enter
- Windows 10: Click Start, find RoBoost in apps list

**From Desktop (if enabled):**

- Double-click the RoBoost shortcut

**From Command Line:**

```cmd
"C:\Users\[YourName]\AppData\Local\RoBoost\RoBoost.exe"
```

### First Time Setup Wizard

If this is your first launch:

1. Click **"Quick Start"**
2. Select Roblox installation location (usually auto-detected)
3. Choose preferred graphics settings
4. Create backup of original settings
5. Review FastFlags settings
6. Click **"Done"**

## 🛠️ Troubleshooting Installation

### SmartScreen Warning

**Problem:** Windows SmartScreen blocks installation

**Solution:**

1. Click **"More info"**
2. Click **"Run anyway"**
3. This is normal for unsigned software; RoBoost is safe

### .NET Runtime Error

**Problem:** "Missing .NET 6 Desktop Runtime"

**Solution:**

1. Download from: https://aka.ms/dotnet-core-applaunch
2. Install the x64 Desktop Runtime
3. Restart your computer
4. Run RoBoost installer again

### Antivirus Blocks Installation

**Problem:** Antivirus software blocks RoBoost

**Solution:**

1. Add RoBoost to antivirus whitelist
2. Or temporarily disable antivirus during installation
3. The following are known safe:
   - Windows Defender
   - Norton
   - McAfee
   - Avast
   - Kaspersky

### Insufficient Permissions

**Problem:** "Access Denied" or permission errors

**Solution:**

1. Right-click RoBoost installer
2. Select **"Run as Administrator"**
3. Click **"Yes"** on UAC prompt
4. Follow installation normally

### Roblox Not Detected

**Problem:** RoBoost can't find Roblox installation

**Solution:**

1. Install Roblox from https://www.roblox.com/download
2. Run Roblox Player once to complete setup
3. Close Roblox completely
4. Launch RoBoost again
5. Roblox should be detected automatically

### Installation Fails Mid-Way

**Problem:** Installation freezes or fails

**Solution:**

1. Close RoBoost completely
2. Clear temp files: `%temp%\roblox`
3. Restart your computer
4. Run installer as Administrator
5. Re-download installer if file is corrupted

## 🔐 Verifying Installation

### Check Installation Folder

Navigate to: `C:\Users\[YourName]\AppData\Local\RoBoost`

Should contain:

- `RoBoost.exe` - Main application
- `RoBoost.ico` - Icon file
- `config/` - Configuration files
- `mods/` - Modifications folder
- `logs/` - Debug logs

### Launch Verification

1. RoBoost window opens
2. "Welcome to RoBoost" message appears
3. Settings button accessible
4. Play button is enabled (if Roblox detected)

### Settings Verification

1. Open Settings
2. All tabs visible:
   - General
   - FastFlags
   - Mods
   - About
3. Settings can be modified and saved
4. No error messages

## 📁 Installation Locations

### Windows Installation Locations

- **Install Folder:** `C:\Users\[YourName]\AppData\Local\RoBoost`
- **Settings Folder:** `C:\Users\[YourName]\AppData\Local\RoBoost\Settings`
- **Modifications:** `C:\Users\[YourName]\AppData\Local\RoBoost\Modifications`
- **Logs:** `C:\Users\[YourName]\AppData\Local\RoBoost\Logs`

### Roblox Integration

- Automatically finds Roblox in: `C:\Users\[YourName]\AppData\Local\Roblox`
- Can manually set Roblox location in settings
- Detects both Player and Studio installations

## 🔄 Uninstalling RoBoost

### Through Windows Settings

1. Go to **Settings** → **Apps** → **Installed apps**
2. Search for **"RoBoost"**
3. Click the three dots → **Uninstall**
4. Confirm uninstallation

### Manual Uninstall

1. Delete folder: `C:\Users\[YourName]\AppData\Local\RoBoost`
2. Delete Start Menu shortcut (if created)
3. Clear any environment variables (if set)

### Keep Settings (Optional)

1. Before uninstalling, backup:
   - `%localappdata%\RoBoost\Settings.json`
   - `%localappdata%\RoBoost\Modifications\`
2. Uninstall RoBoost
3. Reinstall RoBoost
4. Restore backed-up files to same location

## 📞 Need Help?

If you encounter installation issues:

1. **Check the FAQ:** https://github.com/Rloxx/RoBoost/wiki/FAQ
2. **Search Issues:** https://github.com/Rloxx/RoBoost/issues
3. **Open New Issue:** Provide:
   - Windows version
   - Error message
   - Installation method used
   - RoBoost version
   - Steps to reproduce

## ✅ Installation Complete

Congratulations! RoBoost is now installed.

**Next Steps:**

1. Launch RoBoost from Start Menu
2. Configure FastFlags if desired
3. Join a Roblox game
4. Enjoy enhanced Roblox experience!

---

**Made by Rloxx**
**Based on RoBoost by pizzaboxer**

