# Enter the Wired

> plug in. install. disappear.

Minimal Linux installer for ACCELA and SLSsteam.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/enter-the-wired | bash
```

## Linux ACCELA package

ACCELA for Linux is distributed as `ACCELA-20260512222534-linux.tar.gz`.

The archive contains:

- `ACCELAINSTALL`
- `ACCELAUNINSTALL`
- `bin/ACCELA.AppImage`
- `bin/accela.png`

The `accela` installer downloads that tarball from the latest GitHub release, or uses a local `ACCELA*.tar.gz` placed next to the script.

## Scripts

- `enter-the-wired` installs everything
- `accela` installs or updates ACCELA
- `fix-deps` fixes missing system dependencies
- `uninstall` removes installed components

## Fix issues

```bash
curl -fsSL https://raw.githubusercontent.com/ciscosweater/enter-the-wired/main/fix-deps | bash
```

## Repo

https://github.com/ciscosweater/enter-the-wired

> no noise. no bloat. just works.
