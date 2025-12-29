# Enter the Wired

A universal bash-based installer for ACCELA with optional SLSsteam integration on Linux.

## What is ACCELA?

ACCELA is an open-source game client built with Python/.NET that provides various features for gaming on Linux. This installer sets up ACCELA with all required dependencies in an isolated Python virtual environment.

## What is SLSsteam?

SLSsteam is a Steam plugin that enables playing games not owned in your Steam library. When enabled, it patches Steam.sh to unlock additional functionality.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired | sh
```

## Features

- **Cross-Distribution Support**
  - Fedora/RHEL/CentOS (dnf)
  - Debian/Ubuntu (apt)
  - Arch Linux (pacman)

- **Automatic Dependency Installation**
  - Python 3.x + pip
  - SDL2 libraries (devel, mixer, image, ttf)
  - GCC/G++ compiler
  - Git
  - libnotify
  - .NET SDK 9.0
  - p7zip

- **ACCELA Setup**
  - Downloads pre-compiled source from catbox.moe
  - Creates isolated Python virtual environment
  - Installs all Python dependencies
  - Configures pygame compatibility

- **Optional SLSsteam Integration**
  - Installs latest release from GitHub
  - Automatic Steam.sh patching with backup
  - Enables `PlayNotOwnedGames` by default
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
Steam backup:  ~/.steam/steam/steam.sh.bak
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

## Manual Uninstallation

1. Remove ACCELA:
```bash
rm -rf ~/.local/share/ACCELA
```

2. Remove SLSsteam:
```bash
rm -rf ~/.local/share/SLSsteam ~/.config/SLSsteam
# Restore steam.sh backup if needed
cp ~/.steam/steam/steam.sh.bak ~/.steam/steam/steam.sh
```

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

## How it Works

1. **Distribution Detection**: Reads `/etc/os-release` to identify the package manager
2. **Dependency Installation**: Installs all required system packages
3. **ACCELA Setup**: Downloads and extracts ACCELA, then sets up the Python venv
4. **SLSsteam (Optional)**: Fetches latest release from GitHub, patches Steam.sh

## Credits

- **nukhes** (Discord) - Original idea and concept
- **ciscosweater** - Main maintainer
- **JD Ros** (YouTube) - LD_AUDIT systemd drop-in integration
- SLSsteam by AceSLS

## License

This installer is provided as-is.

## Repository

[https://github.com/ciscosweater/enter-the-wired](https://github.com/ciscosweater/enter-the-wired)
