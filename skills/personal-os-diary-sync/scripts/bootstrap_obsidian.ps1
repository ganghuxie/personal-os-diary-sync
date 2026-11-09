[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$VaultPath,

    [switch]$InstallObsidian,

    [switch]$SkipLaunch
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Find-ObsidianExecutable {
    $candidates = @(
        (Join-Path $env:LOCALAPPDATA 'Obsidian\Obsidian.exe'),
        (Join-Path $env:LOCALAPPDATA 'Programs\Obsidian\Obsidian.exe'),
        (Join-Path $env:ProgramFiles 'Obsidian\Obsidian.exe')
    )

    if (${env:ProgramFiles(x86)}) {
        $candidates += Join-Path ${env:ProgramFiles(x86)} 'Obsidian\Obsidian.exe'
    }

    $command = Get-Command 'Obsidian.exe' -ErrorAction SilentlyContinue
    if ($command) {
        $candidates = @($command.Source) + $candidates
    }

    $appPathKeys = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\Obsidian.exe',
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\App Paths\Obsidian.exe',
        'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\App Paths\Obsidian.exe'
    )
    foreach ($key in $appPathKeys) {
        $item = Get-ItemProperty -LiteralPath $key -ErrorAction SilentlyContinue
        if ($item -and $item.'(default)') {
            $candidates = @($item.'(default)') + $candidates
        }
    }

    foreach ($candidate in $candidates | Select-Object -Unique) {
        if ($candidate -and (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            return (Resolve-Path -LiteralPath $candidate).Path
        }
    }

    return $null
}

if (-not [IO.Path]::IsPathRooted($VaultPath)) {
    throw 'VaultPath must be an absolute path.'
}

$resolvedVaultPath = [IO.Path]::GetFullPath($VaultPath)
if (Test-Path -LiteralPath $resolvedVaultPath -PathType Leaf) {
    throw "VaultPath points to a file, not a directory: $resolvedVaultPath"
}

$obsidianPath = Find-ObsidianExecutable
$installedBefore = [bool]$obsidianPath
$installedNow = $false

if (-not $obsidianPath) {
    if (-not $InstallObsidian) {
        throw 'Obsidian is not installed. Re-run with -InstallObsidian only after the user has authorized installation.'
    }

    $winget = Get-Command 'winget.exe' -ErrorAction SilentlyContinue
    if (-not $winget) {
        throw 'Windows Package Manager (winget) is unavailable. Use the official installer from https://obsidian.md/download and rerun this script.'
    }

    & $winget.Source show --id 'Obsidian.Obsidian' --exact --source winget --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        throw 'Could not verify the Obsidian.Obsidian package in the winget source.'
    }

    & $winget.Source install --id 'Obsidian.Obsidian' --exact --source winget --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        throw "Obsidian installation failed with exit code $LASTEXITCODE."
    }

    $obsidianPath = Find-ObsidianExecutable
    if (-not $obsidianPath) {
        throw 'The installer completed, but Obsidian.exe could not be found. Do not report installation as verified.'
    }

    $installedNow = $true
}

$requiredDirectories = @(
    'Personal-OS\Raw',
    'Personal-OS\Daily',
    'Personal-OS\Weekly',
    'Personal-Brain\Raw',
    'Personal-Brain\BRAIN',
    'Personal-Brain\Weekly',
    '04-Life\Daily'
)

$createdDirectories = [System.Collections.Generic.List[string]]::new()
$verifiedDirectories = [System.Collections.Generic.List[string]]::new()

if (-not (Test-Path -LiteralPath $resolvedVaultPath)) {
    New-Item -ItemType Directory -Path $resolvedVaultPath | Out-Null
    $createdDirectories.Add($resolvedVaultPath)
}

foreach ($relativePath in $requiredDirectories) {
    $target = Join-Path $resolvedVaultPath $relativePath
    if (Test-Path -LiteralPath $target -PathType Leaf) {
        throw "A required directory path is occupied by a file: $target"
    }
    if (-not (Test-Path -LiteralPath $target -PathType Container)) {
        New-Item -ItemType Directory -Path $target | Out-Null
        $createdDirectories.Add($target)
    }
    $verifiedDirectories.Add((Resolve-Path -LiteralPath $target).Path)
}

$launched = $false
if (-not $SkipLaunch) {
    Start-Process -FilePath $obsidianPath
    $launched = $true
}

[ordered]@{
    status = 'prepared'
    installed_before = $installedBefore
    installed_now = $installedNow
    obsidian_executable = $obsidianPath
    obsidian_launched = $launched
    vault_path = $resolvedVaultPath
    directories_created = @($createdDirectories)
    directories_verified = @($verifiedDirectories)
    next_action = 'Open this folder as a Vault in Obsidian, then run the isolated PAM acceptance test. Prepared does not mean formally synced.'
} | ConvertTo-Json -Depth 5

