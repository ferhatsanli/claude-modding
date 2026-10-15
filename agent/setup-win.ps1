# Sets up the modding root for Claude Code on Windows.
# Usage (from the repo's agent folder):
#   powershell -ExecutionPolicy Bypass -File .\setup-win.ps1
#   powershell -ExecutionPolicy Bypass -File .\setup-win.ps1 -Root "D:\Modding" -InstallTools

param(
    [string]$Root = "$env:USERPROFILE\Desktop\Modding",
    [int]$CompactPercent = 65,
    [switch]$InstallTools
)

$ErrorActionPreference = "Stop"
$source = $PSScriptRoot

if ($InstallTools) {
    Write-Host "Installing tools with winget..."
    $packages = "Git.Git", "Python.Python.3.12", "Gyan.FFmpeg", "astral-sh.uv", "OpenJS.NodeJS.LTS"
    foreach ($p in $packages) {
        winget install --id $p --exact --silent --accept-package-agreements --accept-source-agreements
    }
    Write-Host "Tools installed. Close and reopen the terminal if a tool is still missing below."
}

Write-Host "Modding root: $Root"
New-Item -ItemType Directory -Force -Path $Root | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Root "games") | Out-Null

# Copy the agent setup. Existing files are overwritten (updates), game folders are never touched.
Copy-Item -Force (Join-Path $source "CLAUDE.md") $Root
Copy-Item -Recurse -Force (Join-Path $source ".claude") $Root
Copy-Item -Recurse -Force (Join-Path $source "templates") $Root
Copy-Item -Force (Join-Path $source "games\README.md") (Join-Path $Root "games")

# Auto-compact threshold must be an environment variable to work reliably.
[Environment]::SetEnvironmentVariable("CLAUDE_AUTOCOMPACT_PCT_OVERRIDE", "$CompactPercent", "User")

# Install the universal-modder CLI (um) if uv is available and um is missing.
if ((Get-Command uv -ErrorAction SilentlyContinue) -and -not (Get-Command um -ErrorAction SilentlyContinue)) {
    uv tool install git+https://github.com/rehan-remade/universal-modder
}

# Report which tools are present.
$tools = "git", "python", "uv", "ffmpeg", "claude", "um"
foreach ($t in $tools) {
    $found = Get-Command $t -ErrorAction SilentlyContinue
    if ($found) { Write-Host "[ok]      $t" } else { Write-Host "[missing] $t" }
}

Write-Host ""
Write-Host "Done. Close and reopen the terminal, then:"
Write-Host "  cd `"$Root`""
Write-Host "  claude"
Write-Host "Inside Claude Code, if the plugin is not installed yet:"
Write-Host "  /plugin marketplace add rehan-remade/universal-modder"
Write-Host "  /plugin install universal-modder@universal-modder"
