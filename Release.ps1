# ==============================================================
# RoBoost Release Script
# Bumps the version, creates a git tag, and pushes to trigger CI
# https://github.com/InfluenceDevs/RoBoost
# ==============================================================
# Usage:
#   .\Release.ps1 -Version 1.0.1
#   .\Release.ps1 -Version 1.1.0 -Push   (also pushes the tag)
# ==============================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$Version,
    [switch]$Push,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Definition
$CsprojPath = Join-Path $Root "RoBoost\RoBoost.csproj"
$ChangelogPath = Join-Path $Root "CHANGELOG.md"

# ── Validate semver format ───────────────────────────────────
if ($Version -notmatch '^\d+\.\d+\.\d+$') {
    Write-Host "[ERROR] Version must be in format X.Y.Z (e.g. 1.0.1)" -ForegroundColor Red
    exit 1
}

$TagName = "v$Version"

Write-Host ""
Write-Host "  RoBoost Release Script" -ForegroundColor Cyan
Write-Host "  Version: $TagName" -ForegroundColor Yellow
if ($DryRun) { Write-Host "  [DRY RUN - no changes will be committed]" -ForegroundColor Magenta }
Write-Host ""

# ── Check git status ─────────────────────────────────────────
$GitStatus = git status --porcelain 2>&1
if ($GitStatus -and -not $DryRun) {
    Write-Host "  [WARN] Uncommitted changes detected:" -ForegroundColor Yellow
    $GitStatus | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
    $confirm = Read-Host "  Continue anyway? (y/N)"
    if ($confirm -ne 'y') { exit 0 }
}

# ── Update version in .csproj ────────────────────────────────
Write-Host "  >> Updating RoBoost.csproj version to $Version..."
$csproj = [xml](Get-Content $CsprojPath -Encoding UTF8)
$csproj.Project.PropertyGroup.Version = $Version
$csproj.Project.PropertyGroup.FileVersion = $Version
if (-not $DryRun) {
    $csproj.Save($CsprojPath)
    Write-Host "     Done." -ForegroundColor Green
} else {
    Write-Host "     [DRY RUN] Would update Version and FileVersion to $Version" -ForegroundColor Magenta
}

# ── Update CHANGELOG ─────────────────────────────────────────
$date = Get-Date -Format "yyyy-MM-dd"
$newEntry = @"
## [$Version] - $date

### Changes
- (fill in changes here)

"@

if (-not $DryRun) {
    $changelogContent = Get-Content $ChangelogPath -Encoding UTF8 -Raw
    # Insert new entry after the first heading line
    $updated = $changelogContent -replace '(# RoBoost Changelog\r?\n\r?\n)', "`$1$newEntry"
    Set-Content $ChangelogPath -Value $updated -Encoding UTF8
    Write-Host "  >> Added CHANGELOG entry for $Version" -ForegroundColor Green
} else {
    Write-Host "  [DRY RUN] Would prepend to CHANGELOG.md:" -ForegroundColor Magenta
    Write-Host $newEntry -ForegroundColor DarkGray
}

# ── Git commit & tag ─────────────────────────────────────────
if (-not $DryRun) {
    Write-Host "  >> Committing version bump..."
    git add RoBoost/RoBoost.csproj CHANGELOG.md
    git commit -m "chore: bump version to $Version"

    Write-Host "  >> Creating git tag $TagName..."
    git tag -a $TagName -m "RoBoost $TagName"

    Write-Host "  >> Tag created: $TagName" -ForegroundColor Green

    if ($Push) {
        Write-Host "  >> Pushing to origin (this will trigger GitHub Actions CI)..."
        git push origin main
        git push origin $TagName
        Write-Host "  >> Pushed! CI will build and create the release automatically." -ForegroundColor Green
        Write-Host "     Check: https://github.com/InfluenceDevs/RoBoost/actions" -ForegroundColor DarkCyan
    } else {
        Write-Host ""
        Write-Host "  Tag created locally. To trigger a release, run:" -ForegroundColor Yellow
        Write-Host "    git push origin main && git push origin $TagName" -ForegroundColor White
        Write-Host "  Or re-run with -Push flag." -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Host "  Done!" -ForegroundColor Green
