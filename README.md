# Enter the Wired

> Universal installer for ACCELA and Steam patching tools on Linux.

## What is ACCELA?

ACCELA is an open-source game client built with Python/.NET that provides various features for gaming on Linux.

> **Important**: There is no single Developer of ACCELA. It materialized on its own from the internet. There are no public repos for the official version, only fork repos exist. Enter the Wired is an **installer only** and is not affiliated with ACCELA's development.

## What is SLSsteam?

SLSsteam is a Steam plugin that enables playing games not owned in your Steam library. It uses LD_AUDIT injection to patch Steam at runtime without modifying Steam files.

## Quick Install (Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired | bash
```

## Scripts

### Linux Scripts

| Script            | Description                     |
| ----------------- | ------------------------------- |
| `enter-the-wired` | Install ACCELA and SLSsteam     |
| `fix-deps`        | Fix missing system dependencies |
| `accela`          | Install/upgrade ACCELA          |
| `slssteam`        | Install/setup SLSsteam          |
| `uninstall`       | Remove all installations        |

## Having Issues?

If you have Linux dependency issues:

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/fix-deps | bash
```

## Features

- **Cross-Distribution Support**: Fedora, Debian/Ubuntu, Arch, Bazzite/SteamOS
- **SLSsteam Integration (Linux)**: LD_AUDIT injection, works in Gaming & Desktop Mode
- **SafeMode**: Enabled by default on Steam Deck

## Credits

- **nukhes** - Original idea and concept
- **ciscosweater** - Main maintainer
- **AceSLS** - SLSsteam developer
- **JD Ros** - LD_AUDIT integration research
- **Deadboy666** - Steam patch logic on Headcrab

## Repository

[https://github.com/ciscosweater/enter-the-wired](https://github.com/ciscosweater/enter-the-wired)
