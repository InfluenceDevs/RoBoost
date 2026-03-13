# ==============================================================
# RoBoost Build Script
# https://github.com/InfluenceDevs/RoBoost
# Made by Rloxx / InfluenceDevs
# ==============================================================
# Usage:
#   .\Build.ps1                 - Build Release (default)
#   .\Build.ps1 -Config Debug   - Build Debug
#   .\Build.ps1 -Installer      - Build Release + create Inno Setup installer
#   .\Build.ps1 -All            - Build Debug, Release, and Installer
# ==============================================================

param(
    [string]$Config = "Release",
    [switch]$Installer,
    [switch]$All,
    [switch]$Run,
    [switch]$Clean
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = $ScriptDir
$CsprojPath = Join-Path $ProjectRoot "RoBoost\RoBoost.csproj"
$SlnPath = Join-Path $ProjectRoot "RoBoost.sln"
$InstallerScript = Join-Path $ProjectRoot "Installer\RoBoost.iss"

# -- Banner --------------------------------------------------
Write-Host ""
Write-Host "  ===============================================" -ForegroundColor Cyan
Write-Host "  RoBoost Build Script" -ForegroundColor Cyan
Write-Host "  ===============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Build Script - github.com/InfluenceDevs/RoBoost" -ForegroundColor DarkCyan
Write-Host "  Made by Rloxx" -ForegroundColor DarkGray
Write-Host ""

# -- Version detection ----------------------------------------
$Version = (Select-Xml -Path $CsprojPath -XPath "//Version").Node.InnerText
Write-Host "  Version: $Version" -ForegroundColor Yellow
Write-Host ""

# -- Helper functions -----------------------------------------
function Step($msg) {
    Write-Host "  >> $msg" -ForegroundColor Green
}

function Error($msg) {
    Write-Host "  [ERROR] $msg" -ForegroundColor Red
    exit 1
}

function BuildConfig($cfg) {
    Step "Building configuration: $cfg"
    $publishDir = Join-Path $ProjectRoot "RoBoost\bin\$cfg\net6.0-windows\win-x64\publish"

    if ($Clean -and (Test-Path $publishDir)) {
        Step "Cleaning previous output for $cfg..."
        Remove-Item -Recurse -Force $publishDir
    }

    # Restore with explicit RID so publish can target win-x64 without NETSDK1047.
    dotnet restore $CsprojPath -r win-x64
    if ($LASTEXITCODE -ne 0) { Error "dotnet restore failed" }

    dotnet build $CsprojPath -c $cfg --no-restore
    if ($LASTEXITCODE -ne 0) { Error "dotnet build failed" }

    dotnet publish $CsprojPath `
        -p:PublishSingleFile=true `
        -r win-x64 `
        -c $cfg `
        --self-contained false `
        --no-restore
    if ($LASTEXITCODE -ne 0) { Error "dotnet publish failed" }

    $exe = Join-Path $publishDir "RoBoost.exe"
    if (-not (Test-Path $exe)) { Error "Output executable not found: $exe" }

    Step "Built: $exe"
    $size = [math]::Round((Get-Item $exe).Length / 1MB, 2)
    Write-Host "    Size: $size MB" -ForegroundColor DarkGray
    return $publishDir
}

function BuildInstaller($version) {
    $iscc = $null

    # Try common Inno Setup installation paths
    $candidates = @(
        "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
        "${env:ProgramFiles}\Inno Setup 6\ISCC.exe",
        "${env:ProgramFiles(x86)}\Inno Setup 5\ISCC.exe"
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) { $iscc = $c; break }
    }

    if (-not $iscc) {
        Write-Host "  [SKIP] Inno Setup not found - skipping installer build." -ForegroundColor Yellow
        Write-Host "         Download from: https://jrsoftware.org/isinfo.php" -ForegroundColor DarkGray
        return
    }

    Step "Building installer with Inno Setup..."
    $outDir = Join-Path $ProjectRoot "Installer\Output"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null

    $innoArgs = @(
        $InstallerScript,
        "/DMyAppVersion=$version",
        "/O$outDir"
    )
    & $iscc @innoArgs
    if ($LASTEXITCODE -ne 0) { Error "Inno Setup build failed" }

    $setupExe = Get-ChildItem $outDir -Filter "*.exe" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($setupExe) {
        $size = [math]::Round($setupExe.Length / 1MB, 2)
        Step ("Installer: {0} ({1} MB)" -f $setupExe.FullName, $size)
    }
}

# -- Main logic -----------------------------------------------
try {
    Set-Location $ProjectRoot

    if ($All) {
        $releaseDir = BuildConfig "Release"
        BuildConfig "Debug" | Out-Null
        BuildInstaller $Version
    } elseif ($Installer) {
        $releaseDir = BuildConfig "Release"
        BuildInstaller $Version
    } else {
        $releaseDir = BuildConfig $Config
    }

    Write-Host ""
    Write-Host "  Build completed successfully!" -ForegroundColor Green
    Write-Host ""

    if ($Run -and $Config -eq "Release") {
        $exe = Join-Path $releaseDir "RoBoost.exe"
        Step "Launching RoBoost..."
        Start-Process $exe
    } elseif ($Run) {
        $exePath = Join-Path $ProjectRoot "RoBoost\bin\$Config\net6.0-windows\win-x64\publish\RoBoost.exe"
        Step "Launching RoBoost ($Config)..."
        Start-Process $exePath
    }

} catch {
    Error "Unexpected error: $_"
}
