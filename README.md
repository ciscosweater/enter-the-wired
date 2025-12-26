# Enter the Wired.

A universal installer for ACCELA with optional SLSsteam integration.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired | sh
```

## Features

- Automatic dependency installation for:
  - Fedora/RHEL/CentOS (dnf)
  - Debian/Ubuntu (apt)
  - Arch Linux (pacman)
- Downloads and installs ACCELA from catbox.moe
- Optional SLSsteam installation for playing games not owned in your library
- Automatic Steam.sh patching
- Cross-distribution support

## Requirements

- Linux with one of the supported distributions
- curl or wget
- sudo access
- For SLSsteam: Steam installed at `$HOME/.steam/steam`

## Manual Installation

If you prefer to review the script before running:

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired -o enter-the-wired
chmod +x enter-the-wired
./enter-the-wired
```

## Uninstall

To remove ACCELA:

```bash
rm -rf ~/.local/share/ACCELA
```

To remove SLSsteam:

```bash
rm -rf ~/.local/share/SLSsteam ~/.config/SLSsteam
# Restore steam.sh backup if needed
cp ~/.steam/steam/steam.sh.bak ~/.steam/steam/steam.sh
```

## Credits

- **nukhes** (Discord) - Original idea and concept
- SLSsteam by AceSLS

## License

This installer is provided as-is.
