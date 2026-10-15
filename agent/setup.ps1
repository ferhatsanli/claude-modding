# Sets up the modding root for Claude Code on Windows.
# Usage (from the repo's agent folder):
#   powershell -ExecutionPolicy Bypass -File .\setup.ps1
#   powershell -ExecutionPolicy Bypass -File .\setup.ps1 -Root "D:\Modding"

param(
    [string]$Root = "$env:USERPROFILE\Desktop\Modding",
    [int]$CompactPercent = 65
)

$ErrorActionPreference = "Stop"
$source = $PSScriptRoot

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
