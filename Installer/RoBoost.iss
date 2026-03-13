; ================================
; RoBoost Inno Setup Installer Script
; Made by Rloxx / InfluenceDevs
; https://github.com/InfluenceDevs/RoBoost
; ================================

#define MyAppName "RoBoost"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "InfluenceDevs"
#define MyAppURL "https://github.com/InfluenceDevs/RoBoost"
#define MyAppExeName "RoBoost.exe"
#define MyAppDescription "Enhanced Roblox Launcher with FastFlags support"
#define MyOutputDir "..\Installer\Output"
#define MySourceDir "..\RoBoost\bin\Release\net6.0-windows\win-x64\publish"

[Setup]
; Application identity
AppId={{E5A1F8B3-4C2D-4F9E-8B1A-7D3C5E9F2A6B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/issues
AppUpdatesURL={#MyAppURL}/releases
AppCopyright=Copyright (C) 2026 InfluenceDevs

; Installation settings
DefaultDirName={localappdata}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; Output settings
OutputDir={#MyOutputDir}
OutputBaseFilename=RoBoost-Setup-{#MyAppVersion}
SetupIconFile=..\RoBoost\RoBoost.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppName}

; Compression
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes

; Visual settings
WizardStyle=modern
WizardSizePercent=120
WizardResizable=no
ShowLanguageDialog=auto

; Installer behavior
DisableWelcomePage=no
DisableDirPage=no
DisableReadyPage=no
AllowNoIcons=no
ChangesAssociations=yes
RestartIfNeededByRun=no

; Minimum version
MinVersion=10.0.17763

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1

[Dirs]
Name: "{app}"; Permissions: everyone-modify

[Files]
; Main executable - self-contained bootstrapper
Source: "{#MySourceDir}\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Start Menu
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"

; Desktop shortcut (optional)
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

; Quick launch (optional, legacy)
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Registry]
; Register as Roblox URL handler - allows launching roblox:// links through RoBoost
Root: HKCU; Subkey: "Software\Classes\roblox"; ValueType: string; ValueName: ""; ValueData: "URL:Roblox Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\roblox"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\roblox\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\roblox\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

Root: HKCU; Subkey: "Software\Classes\roblox-player"; ValueType: string; ValueName: ""; ValueData: "URL:Roblox Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\roblox-player"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\roblox-player\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\roblox-player\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Flags: uninsdeletekey

[Run]
; Launch RoBoost after install
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
; Clean up on uninstall - pass the -uninstall flag for graceful removal
Filename: "{app}\{#MyAppExeName}"; Parameters: "-uninstall -quiet"; Flags: waituntilterminated

[UninstallDelete]
; Remove leftover folders on uninstall
Type: filesandordirs; Name: "{app}"

[Code]
// -------------------------------------------------------
// Pascal script for custom installer logic
// -------------------------------------------------------

// Check .NET 6 Desktop Runtime is installed
function IsDotNetInstalled(): Boolean;
var
  KeyPath: string;
  Value: string;
begin
  KeyPath := 'SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedfx\Microsoft.WindowsDesktop.App';
  Result := RegQueryStringValue(HKLM64, KeyPath, '6.0', Value) or
            RegQueryStringValue(HKLM32, KeyPath, '6.0', Value);
  if not Result then
  begin
    // Fallback: check for any 6.x key
    Result := RegKeyExists(HKLM64, 'SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedfx\Microsoft.WindowsDesktop.App');
  end;
end;

// Called on page initialization - warn if .NET is missing
procedure InitializeWizard();
begin
  if not IsDotNetInstalled() then
  begin
    MsgBox(
      'RoBoost requires the .NET 6 Desktop Runtime to run.' + #13#10 + #13#10 +
      'After the installer finishes, you will be prompted to install .NET if it is missing, or you can download it from:' + #13#10 +
      'https://dotnet.microsoft.com/download/dotnet/6.0' + #13#10 + #13#10 +
      'Make sure to install the Desktop Runtime (not just the base runtime).',
      mbInformation, MB_OK
    );
  end;
end;

// Gracefully close any running RoBoost before installing over it
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  RoBoostRunning: Boolean;
  ResultCode: Integer;
begin
  RoBoostRunning := True;
  while RoBoostRunning do
  begin
    if FindWindowByClassName('WpfUiWindow') <> 0 then
    begin
      if MsgBox(
        'RoBoost is currently running. Please close it before continuing.',
        mbConfirmation, MB_OKCANCEL
      ) = IDCANCEL then
      begin
        Result := 'Installation cancelled.';
        Exit;
      end;
    end
    else
      RoBoostRunning := False;
  end;
  Result := '';
end;
