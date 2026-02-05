#!/usr/bin/env pwsh
#Requires -Version 5.1

<#
.SYNOPSIS
  GreenLuma Installation Script for Windows
.DESCRIPTION
  Downloads and installs GreenLuma to enable playing Steam games without owning them.
.PARAMETER SteamPath
  Custom Steam installation path
.NOTES
  IMPORTANT: Close Steam completely before running this script!
#>

[CmdletBinding()]
param(
    [string]$SteamPath
)

# Detect pipe execution (irm ... | pwsh)
$scriptPath = $PSCommandPath
$runningViaPipe = [string]::IsNullOrEmpty($scriptPath) -or $scriptPath -eq "-"

function Write-Status {
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet('Info', 'Success', 'Warning', 'Error')]
        [string]$Type = 'Info'
    )

    $colors = @{
        'Info'    = 'Cyan'
        'Success' = 'Green'
        'Warning' = 'Yellow'
        'Error'   = 'Red'
    }

    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] " -NoNewline -ForegroundColor DarkGray
    Write-Host $Message -ForegroundColor $colors[$Type]
}

function Find-SteamInstallation {

    # Common Steam installation paths
    $steamPaths = @(
        "$env:ProgramFiles\Steam",
        "${env:ProgramFiles\(x86)}\Steam",
        "$env:LOCALAPPDATA\Steam",
        "$env:ProgramW6432\Steam"
    )

    foreach ($path in $steamPaths) {
        if (Test-Path $path) {
            $steamExe = Join-Path $path "steam.exe"
            if (Test-Path $steamExe) {
                return $path
            }
        }
    }

    # Try to find via registry
    try {
        $regPath = "HKLM:\SOFTWARE\Valve\Steam"
        if (Test-Path $regPath) {
            $installPath = Get-ItemProperty -Path $regPath -Name "InstallPath" -ErrorAction SilentlyContinue
            if ($installPath -and (Test-Path $installPath.InstallPath)) {
                return $installPath.InstallPath
            }
        }

        $regPathWow = "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam"
        if (Test-Path $regPathWow) {
            $installPath = Get-ItemProperty -Path $regPathWow -Name "InstallPath" -ErrorAction SilentlyContinue
            if ($installPath -and (Test-Path $installPath.InstallPath)) {
                return $installPath.InstallPath
            }
        }
    }
    catch {
        # Registry access failed, continue with other methods
    }

    return $null
}

function Close-SteamProcess {

    Write-Status "Checking for running Steam processes..." -Type Info

    $steamProcesses = Get-Process -Name "steam" -ErrorAction SilentlyContinue

    if ($steamProcesses) {
        Write-Status "Found running Steam processes, attempting to close gracefully..." -Type Warning

        # Try graceful shutdown via steam://exit
        try {
            Start-Process "steam://exit" -ErrorAction SilentlyContinue
        }
        catch {
            # steam:// protocol might not work
        }

        # Wait for processes to close
        $attempts = 0
        while ($steamProcesses -and $attempts -lt 30) {
            Start-Sleep -Seconds 1
            $attempts++
            $steamProcesses = Get-Process -Name "steam" -ErrorAction SilentlyContinue
        }

        if ($steamProcesses) {
            Write-Status "Steam did not close gracefully, forcing close..." -Type Warning
            $steamProcesses | Stop-Process -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
        }

        Write-Status "Steam closed successfully" -Type Success
    }
    else {
        Write-Status "No Steam processes running" -Type Info
    }
}

function Test-Admin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    )
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-WebDownload {
    param(
        [Parameter(Mandatory)][string]$Url,
        [Parameter(Mandatory)][string]$OutputPath
    )
    Write-Status "Downloading..." -Type Info
    Invoke-WebRequest -Uri $Url -OutFile $OutputPath -ErrorAction Stop
}

function Install-GreenLumaWindows {
    [CmdletBinding()]
    param(
        [string]$SteamPath
    )

    Write-Status "Installing GreenLuma for Windows..." -Type Success
    Write-Host ""

    # Check for admin rights (needed for some operations)
    if (-not (Test-Admin)) {
        Write-Status "Warning: Running without administrator privileges" -Type Warning
        Write-Status "Some operations may require admin rights" -Type Warning
    }

    # Close Steam
    Close-SteamProcess

    # Verify Steam is closed
    $steamStillRunning = Get-Process -Name "steam" -ErrorAction SilentlyContinue
    if ($steamStillRunning) {
        Write-Status "Error: Steam is still running. Please close it manually." -Type Error
        exit 1
    }

    # Find Steam installation
    if (-not $SteamPath) {
        $SteamPath = Find-SteamInstallation
    }

    if (-not $SteamPath) {
        Write-Status "Steam installation not found!" -Type Error
        Write-Status "Please specify Steam path with -SteamPath parameter" -Type Info
        exit 1
    }

    Write-Status "Found Steam at: $SteamPath" -Type Success

    $steamExe = Join-Path $SteamPath "steam.exe"
    if (-not (Test-Path $steamExe)) {
        Write-Status "steam.exe not found at $steamExe" -Type Error
        exit 1
    }

    # Download GreenLuma from Catbox
    $tempDir = Join-Path ([System.IO.Path]::GetTempPath()) "greenluma-$(Get-Random)"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    $zipPath = Join-Path $tempDir "greenluma.zip"
    Invoke-WebDownload -Url "https://files.catbox.moe/l1kds4.zip" -OutputPath $zipPath

    # Extract zip
    Write-Status "Extracting GreenLuma..." -Type Info
    Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force

    # Run DeleteSteamAppCache.exe
    $stealthModeDir = Join-Path $tempDir "StealthMode"
    $deleteCacheExe = Join-Path $stealthModeDir "DeleteSteamAppCache.exe"
    if (Test-Path $deleteCacheExe) {
        Write-Status "Running DeleteSteamAppCache.exe..." -Type Info
        Start-Process -FilePath $deleteCacheExe -Wait
    }

    # Copy NormalMode/* to Steam directory
    $normalModeDir = Join-Path $tempDir "NormalMode"
    if (Test-Path $normalModeDir) {
        Write-Status "Copying NormalMode files to Steam directory..." -Type Info
        Copy-Item -Path (Join-Path $normalModeDir "*") -Destination $SteamPath -Recurse -Force
    }

    # Create DLLInjector.exe shortcut on desktop
    $shortcutPath = Join-Path ([System.Environment]::GetFolderPath("Desktop")) "GreenLuma.lnk"
    $injectorPath = Join-Path $SteamPath "DLLInjector.exe"
    if (Test-Path $injectorPath) {
        Write-Status "Creating desktop shortcut..." -Type Info
        $wsShell = New-Object -ComObject WScript.Shell
        $shortcut = $wsShell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = $injectorPath
        $shortcut.IconLocation = "$steamExe,0"
        $shortcut.WorkingDirectory = $SteamPath
        $shortcut.Save()
    }
    else {
        Write-Status "DLLInjector.exe not found at '$injectorPath'. Skipping shortcut creation." -Type Warning
    }

    Write-Host ""
    Write-Status "GreenLuma installed successfully!" -Type Success
    Write-Status "Use the desktop shortcut to inject GreenLuma into Steam." -Type Info
    Write-Host ""
}

# Run installation
Install-GreenLumaWindows
