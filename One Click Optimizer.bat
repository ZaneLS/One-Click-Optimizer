@echo  off
color b
chcp 65001 >nul
title OptiClub V6.6-BETA -One Click Optimizer  04-25-2026 -https://discord.gg/Np77z4C9qs
echo Creating Restore Point
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f
powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Optimization Club Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
cls
md %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\

echo HKLM, HKCU, HKCR Keys Exported in "Desktop\OptiClub\RegeditBackUpKeys"
REG EXPORT HKLM %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\HKLM.reg
REG EXPORT HKCU %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\HKCU.reg
REG EXPORT HKCR %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\HKCR.reg

md %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig

reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig\Enum.reg
reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig\CurrentControlSet.reg
reg export "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig\ControlSet001.reg
timeout /t 2 /nobreak > NUL

md %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\AutoFolderDiscovery
reg export "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\AutoFolderDiscovery\Bags.reg
reg export "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\AutoFolderDiscovery\Shell.reg

start %windir%\explorer.exe "%UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\"
:: Disable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f 

:: Getting Admin Permissions https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
echo Checking for Administrative Privelages...
timeout /t 3 /nobreak > NUL
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto GotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:GotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
	
chcp 65001 >nul
Reg.exe add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f
color b
color b
cls
goto menu
:Menu

echo Disabling Tasks
timeout /t 1 /nobreak > NUL
echo Xbox Tasks
timeout /t 1 /nobreak > NUL
schtasks /end /tn "\Microsoft\XblGameSave\XblGameSaveTask"
schtasks /change /tn "\Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /end /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon"
schtasks /change /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon" /disable
timeout /t 1 /nobreak > NUL
echo Done!
timeout /t 1 /nobreak > NUL
echo Other Tasks
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask"
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable"
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor"
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh"
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /disable
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload"
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /disable
schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy"
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT"
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent"
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /disable
schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics"
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /disable
schtasks /end /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
schtasks /change /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks"
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /disable
schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo"
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /end /tn "\Microsoft\Windows\AppID\SmartScreenSpecific"
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /disable
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
schtasks /end /tn "\Microsoft\Windows\HelloFace\FODCleanupTask"
schtasks /change /tn "\Microsoft\Windows\HelloFace\FODCleanupTask" /disable
schtasks /end /tn "\Microsoft\Windows\Feedback\Siuf\DmClient"
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /disable
schtasks /end /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable
schtasks /end /tn "\Microsoft\Windows\Device Information\Device"
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /disable
schtasks /end /tn "\Microsoft\Windows\Device Information\Device User"
schtasks /change /tn "\Microsoft\Windows\Device Information\Device User" /disable
timeout /t 1 /nobreak > NUL
echo Done!
timeout /t 1 /nobreak > NUL

echo Adding Win32Priority Separation Tweaks (Default value is "2", new one is "2")
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "2" /f
timeout /t 1 /nobreak > NUL

echo Enabling MSI-Mode 
for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "3" /f
)
timeout /t 1 /nobreak > NUL
cls
echo Disabling Segment Heap for unstable apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrserver.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrwebhelper.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamvr.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrcompositor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrdashboard.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\melonloader.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "RobloxPlayerBeta.exe" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "WhoCrashedEx.exe" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
echo Done!

cls
color b
echo Downloading Segment Heap Manager.
echo CLICK ENABLE
md %UserProfile%\Desktop\OptiClub\SegmentHeapManager\

PowerShell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/SegmentHeapManagerv2.6.1.ps1" -OutFile "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1"
powershell.exe -File "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1" 
timeout /t 1 /nobreak > NUL

cls
echo Disabling DWM CPU Clipping
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableCpuClipping" /t REG_DWORD /d "1" /f

echo Disabling DWM Animations
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v ForceDisableModeChangeAnimation /t REG_DWORD /d 1 /f   
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v ForceEffectMode /t REG_DWORD /d 0 /f   


cls

REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "LowRiskFileTypes" /T "REG_SZ" /D ".avi;.bat;.cmd;.exe;.htm;.html;.lnk;.mpg;.mpeg;.mov;.mp3;.mp4;.mkv;.msi;.m3u;.rar;.reg;.txt;.vbs;.wav;.zip;.7z" /F
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation" /T "REG_DWORD" /D "00000001" /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersionInternet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "00000000" /F
REG ADD "HKLM\Software\Microsoft\WindowsCurrentVersion\Internet Settings\Zones\3" /V "1806" /T "REG_DWORD" /D "00000000" /F
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /V "DisableSecuritySettingsCheck" /T "REG_DWORD" /D "0" /F

timeout /t 1 /nobreak > NUL

cls
echo Changing "Performances" parameters
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "WindowAnimations" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ThumbnailCacheSize" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FontSmoothing" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableAnimations" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "MenuAnimations" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "Max Cached Icons" /t REG_DWORD /d "8192" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "MaxCachedIcons" /t REG_SZ /d "8192" /f
echo ...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations" /v DefaultValue /t REG_DWORD /d 0 /f   
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows" /v DefaultValue /t REG_DWORD /d 0 /f   
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f   
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultValue /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultValue /t REG_DWORD /d 0 /f  
echo disabling smooth scroll (default value = deleted)
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /v "SmoothScroll" /t REG_DWORD /d 0 /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling remnant touches and the shortcut to enable it
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "482" /f
timeout /t 1 /nobreak > NUL

cls

echo Enabling Num Lock on Startup (value can be 2147483648 or 80000002 or just 2)
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Adaptive Refresh Rate
reg add "HKLM\CurrentControlSet\Control\Power\ModernSleep" /v "AdaptiveRefreshRate" /t REG_DWORD /d "0" /f

cls

echo Enabling ThreadDPC (default value=deleted)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Core parking via Regedit (Default value = 1, changed to 0)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

echo Changing "Valuemax" value (default 100, changed to 100)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "100" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling GameBarPresenceWriter by regedit
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Deleting/Rename GameBarPresenceWriter so it doesn't start anymore.
taskkill /im GameBarPresenceWriter.exe /f
takeown /f "%WinDir%\System32\GameBarPresenceWriter.exe" /a
icacls "%WinDir%\System32\GameBarPresenceWriter.exe" /grant:r Administrators:F /c
takeown /f "C:\Windows\System32\GameBarPresenceWriter.exe"
move "C:\Windows\System32\GameBarPresenceWriter.exe" "C:\Windows\System32\GameBarPresenceWriter.old"
taskkill /im GameBarPresenceWriter.exe /f
move "C:\Windows\System32\GameBarPresenceWriter.exe" "C:\Windows\System32\GameBarPresenceWriter.OLD"
timeout /t 3 /nobreak > NUL


timeout /t 1 /nobreak > NUL

cls

echo Adding key "IsLowPriority" for GPU Interference, this key is a "test" key and might not do anything (the default value is "1")
reg add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\ThrottleGPUInterference" /v "IsLowPriority" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL


timeout /t 1 /nobreak > NUL

cls

echo Disabling Tailored Experiences (Default value = 1..? (depends on the W10/11 Version/Tweaks already applied)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f

timeout /t 1 /nobreak > NUL
cls

timeout /t 1 /nobreak > NUL
cls
color b
echo Disabling Transparency effects
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Enabling GameMode
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f 
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL
cls

echo Disabling Core Integrity (Default Value "1")
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Gamebar
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement" /v "AllowGameDVR" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
echo disabling BcastDRVUserService (default value = 3)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f 
timeout /t 1 /nobreak > NUL

color b
cls

echo %z%Do you have an Nvidia or AMD GPU ?%q%
echo.
echo %i%Nvidia GPU = 1%q%
echo.
echo %i%AMD GPU = 2%q%
echo.
echo %i%Skip = 3%q%
color b
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto NvidiaHAGSActivator
if '%choice%'=='2' goto AMDVRRActivator
if '%choice%'=='3' goto AfterHAGSORVRR

:NvidiaHAGSActivator
cls
color b
echo Enabling Hardware-Accelerated Gpu Scheduling (can cause issues for VR-Games)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchedMode" /t REG_DWORD /d "2" /f

echo "HAGS" apparently cause Stuttering problems ALL OVER windows 11, try it ON/OFF to see, sorry.
timeout /t 1 /nobreak > NUL
cls
echo Applying a new Nvidia Profile
color b
timeout /t 1 /nobreak > NUL
echo Applying NVIDIA Inspector Profile (PLEASE MAKE SURE TO ENABLE RBAR IN THE APP, AND SET THE RIGHT SETTINGS IF NEEDED)
curl -g -k -L -# -o "%temp%\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/latest/download/nvidiaProfileInspector.zip"
powershell -NoProfile Expand-Archive '%temp%\nvidiaProfileInspector.zip' -DestinationPath 'C:\NvidiaProfileInspector\'
curl -g -k -L -# -o "C:\NvidiaProfileInspector\Extreme2_VerticalSync_On3DGameSettings.nip" "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Extreme2_VerticalSync_On3DGameSettings.nip"
start "" /wait "C:\NvidiaProfileInspector\nvidiaProfileInspector.exe" "C:\NvidiaProfileInspector\Extreme2_VerticalSync_On3DGameSettings.nip"
start "" /wait "C:\NvidiaProfileInspector\nvidiaProfileInspector.exe"
echo Applying NVIDIA Inspector Profile (PLEASE MAKE SURE TO ENABLE RBAR IN THE APP, AND SET THE RIGHT SETTINGS IF NEEDED, AND MAKE SURE TO APPLY)
timeout /t 3 /nobreak > NUL
echo Done
timeout /t 2 /nobreak > NUL
goto AfterHAGSORVRR

:AMDVRRActivator
cls
color b
echo Enabling Windowed Game Optimizations and VRR for AMD
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=1;SwapEffectUpgradeEnable=1;" /f
timeout /t 1 /nobreak > NUL
cls
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSnapshot" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowRSOverlay" /t REG_SZ /d "false" /f
rem # Disable DMA Copy
rem # Direct Memory Access (DMA) engines for data transfers between system memory and the GPU, or within the GPU itself
rem # Uses GPU instead of CPU for DMA (similar to HAGS)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDMACopy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DisableDMACopy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_GPUPowerDownEnabled" /t REG_DWORD /d "0" /f
echo Disabling MobileLink (OverCloudAuth)
reg add  "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MobileLinkOverCloudAuth_NA" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Disabling Anti-Aliasing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AAF_NA" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AntiAlias_NA" /t REG_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ASTT_NA" /t REG_SZ /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SurfaceFormatReplacements" /t REG_BINARY /d "31 0" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "31 0" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_DEF" /t REG_SZ /d "4" /f
echo Enabling MSI-Mode for AMD Gpu
for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "3" /f
)
timeout /t 1 /nobreak > NUL
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Main3D" /t REG_BINARY /d "3100" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D" /t REG_BINARY /d "3100" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_DEF" /t REG_SZ /d "1" /f
reg add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f
reg add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f
reg add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDynamicPstate" /t REG_DWORD /d "1" /f
echo Successfully Disabled GPU Powergating
echo Done
timeout /t 2 /nobreak > NUL
goto AfterHAGSORVRR

:AfterHAGSORVRR
cls
color b
echo Disabling Windows Insider Experiments
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Windows Tips
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Windows Spotlight
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Shared Experiences
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Bing Search
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Background Apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo adding IRQ8 Priority (basic value doesn't exist, deleted)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

cls
echo Adding IRQ0 Priority
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ0Priority" /t REG_DWORD /d 1 /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Adding MenuShowDelay tweak (basic value 1)
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
echo disabling power Throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling GPU Energy Driver
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Fast Startup
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Sleep Study
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Fault Tolerant Heap (default value "1")
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Service Host Splitting (SvcHosts) (Documentation : "https://learn.microsoft.com/en-us/windows/application-management/svchost-service-refactoring")

powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Disable-SvcHosts-Splitting.ps1" -OutFile "%temp%\Disable-SvcHosts-Splitting.ps1"
start powershell "" "%temp%\Disable-SvcHosts-Splitting.ps1"

pause

color b

color b
cls


echo Disabling Memory Compression
PowerShell -Command "Disable-MMAgent -MemoryCompression"
timeout /t 1 /nobreak > NUL

echo Disabling Page Combining
PowerShell -Command "Disable-MMAgent -PageCombining"
timeout /t 1 /nobreak > NUL

cls

echo Setting Game Priorities/MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f
timeout /t 1 /nobreak > NUL

echo Disabling Shaking to minimize
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL
echo a few more tweaks.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation" /v "EnableFrameServerMode" /t REG_DWORD /d "0" /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d "8" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f
timeout /t 1 /nobreak > NUL
echo Done!
timeout /t 1 /nobreak > NUL
color b

cls

md %UserProfile%\Desktop\OptiClub\OOSU10\Cfg

powershell Invoke-WebRequest "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -OutFile "%UserProfile%\Desktop\OptiClub\OOSU10\OOSU10.exe"
timeout /t 3 /nobreak > NUL
powershell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/Opticlub-V6.6-B.Config.cfg" -OutFile "%UserProfile%\Desktop\OptiClub\OOSU10\Cfg\Opticlub-V6.6-B.Config.cfg"
set OOSUPath="%UserProfile%\Desktop\OptiClub\OOSU10\OOSU10.exe"
set ConfigPath="%UserProfile%\Desktop\OptiClub\OOSU10\Cfg\Opticlub-V6.6-B.Config.cfg"

if exist %OOSUPath% (
    if exist %ConfigPath% (
        %OOSUPath% %ConfigPath%
    )
)
start "" /wait "%UserProfile%\Desktop\OptiClub\OOSU10\OOSU10.exe"
echo Done.
color b
cls
color b
echo Disable Telemetry Services
echo Disabling Telemetry Services 
sc stop DiagTrack 
sc config DiagTrack start= disabled 
sc stop dmwappushservice 
sc config dmwappushservice start= disabled 
sc stop diagnosticshub.standardcollector.service 
sc config diagnosticshub.standardcollector.service start= disabled 
timeout /t 1 /nobreak > NUL
cls
echo adding NDU Tweak
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f
cls
color b
echo Disabling Delivery Optimization
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
echo disabling location Tracking
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo adding a few regedit Tweaks
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d "2" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "IsFeedsAvailable" /t REG_DWORD /d "2" /f

echo Disabling Consumer Features (Windows 10 will not automatically install any games, third-party apps)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "0" /f
echo or application links from the Windows Store for the signed-in user. Some default Apps will be inaccessible (eg. Phone Link)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvide" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling RPC over Scheduler. (default value = del)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule" /v "DisableRpcOverTcp" /t REG_DWORD /d "00000001" /f
timeout /t 1 /nobreak > NUL
color b
timeout /t 1 /nobreak > NUL
echo Done.
color b
cls
echo Setting Windows Privacy Settings
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Allow" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Prompt" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Prompt" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation\Microsoft.AccountsControl_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Prompt" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Allow" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Allow" /f 
timeout /t 1 /nobreak > NUL

echo Disabling Location Tracking (FROM https://github.com/ChrisTitusTech/winutil/blob/main/config/tweaks.json)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo disabling error reporting
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
timeout /t 1 /nobreak > NUL
echo adding a few regedit Tweaks
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo disabling AeroPeek
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\ExtendedComposition" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
echo ...

color b
timeout /t 1 /nobreak > NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
cls

echo Disable sending Windows Media Player statistics
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "00000000" /f
timeout /t 1 /nobreak > NUL
echo Disabling Edge Diagnostics
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "TabServicesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AlternateErrorPagesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d "00000001" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d "00000000" /f
timeout /t 1 /nobreak > NUL
echo Disabling UWP apps / Bloatwares apps to come background
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
cls
echo Disabling WpnService connection to Microsoft (This keeps the service enabled and working, just disable its connection to online servers)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoCloudApplicationNotification" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
cls
echo Done.
timeout /t 5 /nobreak > NUL
color b
cls
powershell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/OptiClub-V6.6.7-B.pow" -OutFile "%temp%\OptiClub-V6.6.7-B.pow"

powercfg -import "%temp%\OptiClub-V6.6.7-B.pow"
start control powercfg.cpl
echo Successfully Imported Custom Powerplan

timeout /t 3 /nobreak > NUL

echo optimizing Power usage (CPU)

echo disabling Hibernation (Default value : "1") (useless if on desktop PC, good for laptops tho)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f
powercfg.exe /hibernate off
cls
echo Disabling Power Throttling (Default Value = 1/Depends)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling "EnergyEstimationEnabled" (Default Value = 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Disabling "EventProcessorEnabled" (Default Value = 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f
echo Disabling Core parking via Regedit (Default value = 1, changed to 0)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Changing "Valuemax" value (default 100, changed to 100)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "100" /f
echo Disabing Core Parking
powershell Invoke-WebRequest "https://coderbag.com/assets/downloads/disable-cpu-core-parking/Unpark-CPU-App.zip" -OutFile "%temp%\Unpark-CPU-App.zip"
powershell -NoProfile Expand-Archive '%temp%\Unpark-CPU-App.zip' -DestinationPath 'C:\UnparkCPUApp\'
start "" /wait "C:\UnparkCPUApp\
echo Disabling Disk-Timeout
powercfg -change -disk-timeout-ac 0
color b
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f


reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender SmartScreen" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f


reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableAnimations" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f 
timeout /t 3 /nobreak > NUL
echo Reducing A few apps (Discord, Steam, Wallpaper) Priority
echo Note : If something goes wrong you can just delete the value.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steam.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Video.UI.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wallpaper32.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wallpaper64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PhotosApp.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Reducing Svchost Priority (this *MAY* cause problems!)
echo Note : If something goes wrong you can just delete the value.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting up Services Priorities
echo Note : If something goes wrong you can just delete the value.
echo Setting "lsass.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "TrustedInstaller.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "wuauclt.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "TextInputHost.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TextInputHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "PhotosService.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PhotosService.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "SearchIndexer.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "5" /f
timeout /t 1 /nobreak > NUL
echo Setting "vrmonitor.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "5" /f
timeout /t 1 /nobreak > NUL
echo Setting "vrdashboard.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrdashboard.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "5" /f
timeout /t 1 /nobreak > NUL
echo Reducing Discord Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Discord.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Discordptb.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DiscordCanary.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling msfeed sync.
msfeedssync disable
echo Enabling CacheAwareScheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CacheAwareScheduling" /t REG_DWORD /d "7" /f
echo Possible Values
echo 0, Disabled
echo 1, Enabled, Basic cache-aware Scheduling
echo 2, Enhanced Cache-Aware Scheduling, Best for multi core systems apparently)
echo 7, Full cache-aware scheduling (combination of flags; default on some systems).
echo Default Value : Deleted

color b
cls

echo PowerShellPackages
echo Removing Unnecessary Powershell Packages
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *people* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage"

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Start\Companions\Microsoft.YourPhone_8wekyb3d8bbwe" /v "IsEnabled" /t REG_DWORD /d "00000000" /f 
   
timeout /t 5 /nobreak > NUL

cls

echo DisableOneDrive
echo Disabling OneDrive
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
rd C:\OneDriveTemp /q /s 
rd "%USERPROFILE%\OneDrive" /q /s 
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /q /s 
rd "%PROGRAMDATA%\Microsoft OneDrive" /q /s 
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v "Attributes" /t REG_DWORD /d "0" 
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v "Attributes" /t REG_DWORD /d "0" 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d "0" /f 
timeout /t 3 /nobreak > NUL

cls

taskkill/im msedge.exe
cd %PROGRAMFILES(X86)%\Microsoft\Edge\Application\1*\Installer
cd C:\Program Files (x86)\Microsoft\Edge\Application\125.0.2535.79\Installer
setup.exe --uninstall --system-level --verbose-logging --force-uninstall
rd /s /q "C:\Program Files (x86)\Microsoft\Edge"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeCore"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView"
rd /s /q "C:\Program Files (x86)\Microsoft\Temp"
takeown /f "C:\Program Files (x86)\Microsoft"
reg add "HKLM\Software\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL
icacls "C:\Program Files (x86)\Microsoft" /deny Everyone:(X)
icacls "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" /deny Everyone:(X)

del /q "C:\Program Files (x86)\Microsoft\EdgeUpdate\*"
echo Disabling Edge/I.E/WebView can cause problems on games like roblox
timeout /t 3 /nobreak > NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "TabServicesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AlternateErrorPagesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d "00000001" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d "00000000" /f

cls

echo DisableCortana
echo Disabling Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f 
timeout /t 2 /nobreak > NUL
Powershell -Command "Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage"
timeout /t 3 /nobreak > NUL

color b

cls

disabling Co-Pilot
Get-AppxPackage -AllUsers -Name "Microsoft.Windows.Copilot" | Remove-AppxPackage -AllUsers   
timeout /t 1 /nobreak > NUL
echo stopping automatic reinstall via updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d "1" /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d "1" /f
timeout /t 3 /nobreak > NUL

color b
cls
echo Disabling Hyper-V
bcdedit /set hypervisorlaunchtype off
bcdedit /set vm off
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor"
sc config vmicguestinterface start= disabled
sc config vmicshutdown start= disabled
sc config vmicvss start= disabled
sc config vmicrdv start= disabled
sc config vmicheartbeat start= disabled
sc config vmickvpexchange start= disabled
sc config vmictimesync start= disabled
sc config HvHost start= disabled
sc config vmcompute start= disabled
sc config vmms start= disabled
echo Done! Disabled Hyper-V And related services.

echo disabling HDAudBus (This may cause problem (Default value "3" for both regedit keys.)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HDAudBus" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HdAudAddService" /v "Start" /t REG_DWORD /d 4 /f
echo Disabling HelpPane.exe
taskkill /f /im HelpPane.exe
takeown /f %WinDir%\HelpPane.exe
icacls %WinDir%\HelpPane.exe /deny Everyone:(X)
takeown /f %WinDir%\HelpPane.exe
move "%WinDir%\HelpPane.exe" "%WinDir%\HelpPane.old"
taskkill /im HelpPane.exe /f
timeout /t 1 /nobreak > NUL

echo Disabling TextInputHost.exe
echo Warning! This is another attempt at disabling TextInputHost, it sometimes can cause a very weird bug in windows where 
echo desktop icons randomly (after a few seconds) gets refreshed and it loops in this bug.
echo this cause performances Issues if it happens, please go to the discord and download "EnableApps.bat" to enable those apps again

echo.
timeout /t 1 /nobreak > NUL
taskkill /f /im TextInputHost.exe
takeown /f "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe"
icacls "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe" /deny Everyone:(X)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnablePerformanceMode" /t REG_DWORD /d 0x00000001 /f
timeout /t 1 /nobreak > NUL

echo Disabling MobSync.exe (MicrosoftSync)
taskkill /f /im mobsync.exe
takeown /f "C:\Windows\System32\mobsync.exe"
icacls "C:\Windows\System32\mobsync.exe" /deny Everyone:(X)
icacls "C:\Windows\System32\mobsync.exe" /remove Everyone:f
timeout /t 1 /nobreak > NUL
echo Disabling SmartScreen.exe (Already disabled, but just in case, we'll revoke the permissions to use it)
taskkill /f /im smartscreen.exe
takeown /f "C:\Windows\System32\smartscreen.exe"
icacls "C:\Windows\System32\smartscreen.exe" /deny Everyone:(X)
icacls "C:\Windows\System32\smartscreen.exe"/remove Everyone:f
timeout /t 1 /nobreak > NUL

echo Disabling Bonjour Service (mdnsNSP.dll)
taskkill /f /im mDNSResponder.exe
takeown /f "C:\Program Files (x86)\Bonjour\mDNSResponder.exe"
icacls "C:\Program Files (x86)\Bonjour\mDNSResponder.exe" /deny Everyone:(X)

takeown /f "C:\Program Files\BonjourmDNSResponder.exe"
icacls "C:\Program Files\Bonjour\mDNSResponder.exe" /deny Everyone:(X)
timeout /t 1 /nobreak > NUL
echo Downloading Ressources...

md %UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Apps
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Apps.rar" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Apps\Apps.rar"
timeout /t 1 /nobreak > NUL
md %UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Video+Picture-Codecs.rar" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs\Video+Picture-Codecs.rar"
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/HEVC-Codecs.rar" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs\HEVC-Codecs.rar"
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Microsoft.HEVCVideoExtension_2.4.13.0_neutral_~_8wekyb3d8bbwe.AppxBundle" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs\HEVCVideoExtension_2.4.13.0_neutral_~_8wekyb3d8bbwe.AppxBundle"
timeout /t 1 /nobreak > NUL
md %UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Windows-Apps-Installer
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Read..txt" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Windows-Apps-Installer\Read..txt"
start %windir%\explorer.exe "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\"
echo You need to be in Windows Safe mode to use this.

cls
md %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\WindowsDefender
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\WindowsDefenderRegKey\WindowsDefender.reg

start %windir%\explorer.exe "%UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\WindowsDefender"

cls
echo Adding regedit Keys.
echo  virus and threat protection - manage settings
echo  real time protection - needs safe boot as trusted installer - windows turns this back on automatically (Key Default Value = 0)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo  dev drive protection - needs safe boot as trusted installer (Key Default Value = 0)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableAsyncScanOnOpen" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL
echo  cloud delivered protection - needs safe boot as trusted installer (Key Default Value = 2)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo  automatic sample submission (Key Default Value = 1)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
echo  tamper protection - needs safe boot as trusted installer (Key Default Value = 1)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "4" /f
timeout /t 1 /nobreak > NUL
echo  virus and threat protection - manage ransomware protection
echo  controlled folder access
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Fully disabling SmartScreen.
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenEnabled" /ve /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f

cls
color b
md %UserProfile%\Desktop\OptiClub\ZipPack
md %UserProfile%\Desktop\OptiClub\ZipPack\NvCleanInstall
md %UserProfile%\Desktop\OptiClub\ZipPack\GoInterruptPolicy
md %UserProfile%\Desktop\OptiClub\ZipPack\GPU-Z
md %UserProfile%\Desktop\OptiClub\ZipPack\ThrottleStop
powershell Invoke-WebRequest "https://de1-dl.techpowerup.com/files/Ypha0b4hRhBbEmpvs5S2FQ/1777049579/NVCleanstall_1.19.0.exe" -OutFile "%UserProfile%\Desktop\OptiClub\ZipPack\NvCleanInstall\NVCleanstall_1.19.0.exe"
powershell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/ZipPack-/refs/heads/main/GoInterruptPolicy.exe" -OutFile "%UserProfile%\Desktop\OptiClub\ZipPack\GoInterruptPolicy\GoInterruptPolicy.exe"
powershell Invoke-WebRequest "https://de1-dl.techpowerup.com/files/gRMAn0QWiCf_cVM53NEw6w/1777049740/GPU-Z.2.69.0.exe" -OutFile "%UserProfile%\Desktop\OptiClub\ZipPack\GPU-Z\GPU-Z.2.69.0.exe"
powershell Invoke-WebRequest "https://de1-dl.techpowerup.com/files/ghRlo7FtNtQeH2wI-EmuMw/1777049814/ThrottleStop_9.7.3.zip" -OutFile "%UserProfile%\Desktop\OptiClub\ZipPack\ThrottleStop\ThrottleStop_9.7.3.zip"
md %UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Apps
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Apps.rar" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Apps\Apps.rar"
timeout /t 1 /nobreak > NUL
md %UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Video+Picture-Codecs.rar" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs\Video+Picture-Codecs.rar"
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/HEVC-Codecs.rar" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs\HEVC-Codecs.rar"
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Microsoft.HEVCVideoExtension_2.4.13.0_neutral_~_8wekyb3d8bbwe.AppxBundle" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Video+Picture-Codecs\HEVCVideoExtension_2.4.13.0_neutral_~_8wekyb3d8bbwe.AppxBundle"
timeout /t 1 /nobreak > NUL
md %UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Windows-Apps-Installer
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Read..txt" -OutFile "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\Windows-Apps-Installer\Read..txt"
start %windir%\explorer.exe "%UserProfile%\Desktop\OptiClub\Apps-Codecs-and-More\"
timeout /t 1 /nobreak > NUL

echo Done, Exiting.

pause
exit