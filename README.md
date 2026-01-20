# Enter the Wired

Universal installer for ACCELA and SLSsteam on Linux.

## What is ACCELA?

ACCELA is an open-source game client built with Python/.NET that provides various features for gaming on Linux.

## What is SLSsteam?

SLSsteam is a Steam plugin that enables playing games not owned in your Steam library. It uses LD_AUDIT injection to patch Steam at runtime without modifying Steam files.

## Quick Install (Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired | bash
```

## Quick Install (Windows)

```powershell
irm https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/windows/enter-the-wired.ps1 | iex
```

## Scripts

### Linux Scripts

| Script | Description |
|--------|-------------|
| `enter-the-wired` | Install ACCELA and SLSsteam |
| `fix-deps` | Fix missing system dependencies |
| `accela` | Install/upgrade ACCELA |
| `slssteam` | Install/setup SLSsteam |
| `cyberia` | Install Millennium + Steam integration |
| `uninstall` | Remove all installations |

### Windows Scripts (PowerShell)

| Script | Description |
|--------|-------------|
| `windows/enter-the-wired.ps1` | Install ACCELA and GreenLuma |
| `windows/accela.ps1` | Install ACCELA for Windows |
| `windows/greenluma.ps1` | Install GreenLuma for Windows |

## Having Issues?

If you have dependency issues:
```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/fix-deps | bash
```

## Features

- **Cross-Platform Support**: Linux and Windows
- **Cross-Distribution Support**: Fedora, Debian/Ubuntu, Arch, Bazzite/SteamOS
- **SLSsteam Integration (Linux)**: LD_AUDIT injection, works in Gaming & Desktop Mode
- **GreenLuma Support (Windows)**: DLL injection for Steam
- **SafeMode**: Enabled by default on Steam Deck

## Support

- Windows 10/11 (PowerShell 5.1+)
- Fedora/RHEL/CentOS (dnf)
- Debian/Ubuntu (apt)
- Arch Linux (pacman)
- Bazzite/SteamOS

## Credits

- **nukhes** - Original idea and concept
- **ciscosweater** - Main maintainer
- **AceSLS** - SLSsteam developer
- **JD Ros** - LD_AUDIT integration research
- **Deadboy666** - Steam patch logic on Headcrab

## Repository

[https://github.com/ciscosweater/enter-the-wired](https://github.com/ciscosweater/enter-the-wired)
