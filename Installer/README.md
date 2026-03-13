# RoBoost Installer

This folder contains the **Inno Setup** installer script for RoBoost.

## Files

| File          | Description                                             |
| ------------- | ------------------------------------------------------- |
| `RoBoost.iss` | Inno Setup installer script                             |
| `Output/`     | Built installer `.exe` files (generated, not committed) |

## Building the Installer Manually

### Prerequisites

1. Install [Inno Setup 6](https://jrsoftware.org/isinfo.php) (free)
2. Build RoBoost in Release mode first (so the exe exists)

### Steps

**Option 1 — Using the build script (recommended):**

```powershell
cd e:\RoBoost
.\Build.ps1 -Installer
```

**Option 2 — Using the Inno Setup GUI:**

1. Open `RoBoost.iss` in Inno Setup Compiler
2. Press `Ctrl+F9` (Build → Compile)
3. Find the output `.exe` in `Installer\Output\`

**Option 3 — Command line:**

```powershell
# Replace path with your Inno Setup installation
& "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe" RoBoost.iss
```

## What the Installer Does

When a user runs `RoBoost-Setup-*.exe`:

1. **Copies** `RoBoost.exe` to `%LocalAppData%\RoBoost\`
2. **Creates** Start Menu shortcut (`RoBoost`)
3. **Optionally creates** a Desktop shortcut (user choice)
4. **Registers** `roblox://` and `roblox-player://` URL protocols so clicking "Play" on the Roblox website opens through RoBoost
5. **Registers** in Windows "Apps & Features" for clean uninstall
6. **Warns** if .NET 6 Desktop Runtime is missing
7. **Launches** RoBoost after installation

## Uninstall

The installer registers a proper uninstaller. Users can remove RoBoost via:

- **Settings → Apps → Installed apps → RoBoost → Uninstall**
- **Control Panel → Programs → RoBoost → Uninstall**

The uninstaller calls `RoBoost.exe -uninstall -quiet` for graceful cleanup before removing files.

## CI/CD

The GitHub Actions workflow (`.github/workflows/ci-release.yml`) automatically builds the installer on every tagged release (`v*`). The resulting setup `.exe` is uploaded to the GitHub Release alongside the portable `.exe`.
