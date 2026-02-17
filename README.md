# Enter the Wired

> Universal installer for ACCELA and Steam patching tools on Linux.

## What is ACCELA?

ACCELA is an open-source game client built with Python/.NET that provides various features for gaming on Linux.

> **Important**: There is no single Developer of ACCELA. It materialized on its own from the internet. There are no public repos for the official version, only fork repos exist. Enter the Wired is an **installer only** and is not affiliated with ACCELA's development.

## What is SLSsteam?

SLSsteam is a Steam plugin that enables playing games not owned in your Steam library. It uses LD_AUDIT injection to patch Steam at runtime without modifying Steam files.

### Headcrab (h3adcr-b) — Deadboy666

This installer now uses Deadboy666's headcrab (h3adcr-b) to install and configure SLSsteam automatically.

- **What it does:** `h3adcr-b` automates fetching, installing and configuring the SLSsteam runtime patch (LD_AUDIT) and applies the necessary Steam hooks without modifying Steam binaries.
- **Why we use it:** it standardizes setup across distributions, handles Steam-specific edge-cases, and is actively maintained upstream.
- **Upstream repo:** https://github.com/Deadboy666/h3adcr-b
- **Security note:** the installer invokes the headcrab tooling; review the upstream README and code if you require an audit before running.

The Enter the Wired scripts call `h3adcr-b` as part of the `slssteam` install flow so SLSsteam is installed and configured consistently across supported platforms.

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
