# Enter the Wired

A universal bash-based installer for ACCELA with optional SLSsteam integration on Linux.

## What is ACCELA?

ACCELA is an open-source game client built with Python/.NET that provides various features for gaming on Linux. This installer sets up ACCELA with all required dependencies in an isolated Python virtual environment.

## What is SLSsteam?

SLSsteam is a Steam plugin that enables playing games not owned in your Steam library. It uses LD_AUDIT injection to patch Steam at runtime without modifying Steam files.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired | sh
```

## Features

- **Cross-Distribution Support**
  - Fedora/RHEL/CentOS (dnf)
  - Debian/Ubuntu (apt)
  - Arch Linux (pacman)
  - Bazzite / SteamOS support

- **Steam Installation Support**
  - Native Steam installation (`~/.steam/steam`)
  - Flatpak Steam installation (`~/.var/app/com.valvesoftware.Steam/.steam/steam`)
  - Automatic detection

- **Automatic Dependency Installation**
  - Python 3.x + pip
  - SDL2 libraries (devel, mixer, image, ttf)
  - GCC/G++ compiler
  - Git
  - libnotify
  - .NET SDK 9.0
  - p7zip
  - Konsole (if no terminal is detected)
  - Non-critical installation - continues on failure

- **Terminal Detection**
  - Checks for: wezterm, konsole, gnome-terminal, ptyxis, alacritty, tilix, xfce4-terminal, terminator, mate-terminal, lxterminal, xterm, kitty
  - Automatically installs Konsole if no terminal is found

- **ACCELA Setup**
  - Downloads pre-compiled source from catbox.moe
  - Creates isolated Python virtual environment
  - Installs all Python dependencies
  - Configures pygame compatibility

- **SLSsteam Integration (LD_AUDIT Injection)**
  - Installs latest release from GitHub
  - Modifies `/usr/bin/steam` to add LD_AUDIT environment variable
  - Patches `steam.sh` in Steam installation directory
  - Creates backup before modification
  - Works in both **Gaming Mode** and **Desktop Mode** on all distributions
  - SafeMode enabled by default (Steam Deck)
  - PlayNotOwnedGames enabled by default
  - Configuration via `~/.config/SLSsteam/config.yaml`

- **Steam Configuration**
  - Automatically creates `steam.cfg` to block Steam updates
  - Opens Steam temporarily to allow updates if needed
  - Recreates `steam.cfg` after Steam updates

## Requirements

- Linux with a supported distribution
- curl or wget
- sudo access
- For SLSsteam: Steam installed (native or Flatpak)

## Installation Locations

```
ACCELA:              ~/.local/share/ACCELA/
SLSsteam (native):   ~/.local/share/SLSsteam/
SLSsteam (Flatpak):  ~/.var/app/com.valvesoftware.Steam/.local/share/SLSsteam/
SLSsteam cfg:        ~/.config/SLSsteam/ (or Flatpak equivalent)
Steam cfg:           ~/.steam/steam/steam.cfg (or Flatpak equivalent)
Steam backup:        /usr/bin/steam.bak
```

## Manual Installation

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired -o enter-the-wired
chmod +x enter-the-wired
./enter-the-wired
```

### Local ACCELA Archive

If you have a local ACCELA archive (`ACCELA*.tar.gz`) in the same directory as the installer, it will be used instead of downloading from the internet. This is useful for:

- Offline installation
- Using a custom or pre-modified ACCELA version
- Faster installation without downloading

```bash
# Place your archive in the same directory as the installer
ls -la
# enter-the-wired
# ACCELA-2025.01.15-linux-source.tar.gz

./enter-the-wired
# Will automatically detect and use the local archive
```

## Automatic Steam Update Handling

When Steam or SLSsteam updates, the installer handles it automatically:
1. Removes `steam.cfg` to allow Steam to update
2. Opens Steam with SLSsteam injection (Steam updates if needed)
3. Closes Steam and recreates `steam.cfg`
4. Patches `/usr/bin/steam` and `steam.sh`

No separate update script needed!

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/uninstall | sh
```

The uninstall script will:
- Restore `/usr/bin/steam` from backup
- Remove desktop shortcut override
- Remove ACCELA directory
- Remove SLSsteam directories (native and Flatpak)

## How it Works

1. **Distribution Detection**: Reads `/etc/os-release` to identify the package manager
2. **Steam Detection**: Checks for native or Flatpak Steam installation
3. **Terminal Check**: Scans for installed terminals, installs Konsole if none found
4. **Dependency Installation**: Attempts to install all required system packages (non-critical, continues on failure)
5. **ACCELA Setup**: Downloads and extracts ACCELA, then sets up the Python venv
6. **SLSsteam**:
   - Fetches latest release from GitHub
   - Creates backup of `/usr/bin/steam`
   - Opens Steam temporarily to allow updates
   - Modifies `/usr/bin/steam` and `steam.sh` to add LD_AUDIT environment variable
   - Works in Gaming Mode and Desktop Mode on all distributions

## Compatibility Matrix

| Distribution | Native Steam | Flatpak Steam |
|--------------|--------------|---------------|
| SteamOS (Steam Deck) | Supported | N/A |
| Bazzite | Supported | N/A |
| Ubuntu/Debian/Fedora/Arch | Supported | Supported |

## Troubleshooting

### Steam is running during SLSsteam installation
The installer will warn you to close Steam before proceeding with SLSsteam installation.

### .NET SDK installation fails
The script uses Microsoft's official installation script. If it fails, the installer will continue with a warning. ACCELA may work without .NET SDK for some features.

### ACCELA fails to start
Check that the virtual environment was created correctly:
```bash
source ~/.local/share/ACCELA/.venv/bin/activate
python -c "import accela"
```

### SLSsteam not working
- Check if LD_AUDIT is set in `/usr/bin/steam`: `grep LD_AUDIT /usr/bin/steam`
- Verify backup exists: `ls -l /usr/bin/steam.bak`
- Restore from backup if needed: `sudo cp /usr/bin/steam.bak /usr/bin/steam`

### No terminal detected
The installer will automatically install Konsole. If you prefer a different terminal, install it manually before running the installer.

## Credits

- **nukhes** (Discord) - Original idea and concept
- **ciscosweater** - Main maintainer
- **JD Ros** (YouTube) - LD_AUDIT integration research
- **AceSLS** - SLSsteam developer
- Community contributors

## License

This installer is provided as-is.

## Repository

[https://github.com/ciscosweater/enter-the-wired](https://github.com/ciscosweater/enter-the-wired)
