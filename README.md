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

- **Automatic Dependency Installation**
  - Python 3.x + pip
  - SDL2 libraries (devel, mixer, image, ttf)
  - GCC/G++ compiler
  - Git
  - libnotify
  - .NET SDK 9.0
  - p7zip
  - Konsole (if no terminal is detected)

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
  - Creates backup before modification
  - Works in both **Gaming Mode** and **Desktop Mode** on all distributions
  - SafeMode enabled by default
  - PlayNotOwnedGames enabled by default
  - Configuration via `~/.config/SLSsteam/config.yaml`

## Requirements

- Linux with a supported distribution
- curl or wget
- sudo access
- For SLSsteam: Steam installed at `$HOME/.steam/steam`

## Installation Locations

```
ACCELA:        ~/.local/share/ACCELA/
SLSsteam:      ~/.local/share/SLSsteam/
SLSsteam cfg:  ~/.config/SLSsteam/
Steam backup:  /usr/bin/steam.bak
```

## Manual Installation

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired -o enter-the-wired
chmod +x enter-the-wired
./enter-the-wired
```

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/uninstall | sh
```

The uninstall script will:
- Restore `/usr/bin/steam` from backup
- Remove desktop shortcut override
- Remove ACCELA directory
- Remove SLSsteam directories

## How it Works

1. **Distribution Detection**: Reads `/etc/os-release` to identify the package manager
2. **Terminal Check**: Scans for installed terminals, installs Konsole if none found
3. **Dependency Installation**: Installs all required system packages
4. **ACCELA Setup**: Downloads and extracts ACCELA, then sets up the Python venv
5. **SLSsteam**:
   - Fetches latest release from GitHub
   - Creates backup of `/usr/bin/steam`
   - Modifies `/usr/bin/steam` to add LD_AUDIT environment variable
   - Works in Gaming Mode and Desktop Mode on all distributions

## Compatibility Matrix

| Distribution | Gaming Mode | Desktop Mode |
|--------------|-------------|--------------|
| SteamOS (Steam Deck) | `/usr/bin/steam` | `/usr/bin/steam` |
| Bazzite | `/usr/bin/steam` | `/usr/bin/steam` |
| Ubuntu/Debian/Fedora/Arch | `/usr/bin/steam` | `/usr/bin/steam` |

**Note:** The installer modifies `/usr/bin/steam` directly on all distributions. A backup is created at `/usr/bin/steam.bak` before modification.

## Troubleshooting

### Steam is running during SLSsteam installation
The installer will warn you to close Steam before proceeding with SLSsteam installation.

### .NET SDK installation fails
The script uses Microsoft's official installation script. If it fails, ensure you have an internet connection and try running the installer again.

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
