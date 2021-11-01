REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience"  /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Windows Smart Guard" /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /f
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /f
REG DELETE "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience"  /f
REG DELETE "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications"  /f
REG DELETE "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications"  /f
REG DELETE "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /f
REG DELETE "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Windows Security Center" /f
REG DELETE "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /f       
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FolderContentsInfoTip" /t REG_DWORD /d 1 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "StartButtonBalloonTip" /t REG_DWORD /d 1 /f
attrib -s -h "C:\Windows\System32\drivers\etc\hosts"
attrib -s -h "C:\Windows\System32\drivers\etc"
taskkill /f /im timeout.exe
taskkill /f /im tor.exe
del /q /f /s /a "%AppData%\Microsoft\Windows\Windows Smart Guard.exe"
del /q /f /s /a "%AppData%\Microsoft\Windows\Templates"
del /q /f /s /a "C:\Windows\SpecialPermissions\win64.bat"
REM del /q /f /s /a "C:\Windows\nircmd.exe"
rmdir /s /q "C:\Tor"
sc config wuauserv start= demand
net start wuauserv
Taskkill /f /im winrun.exe
del /s /f /q %Temp%
taskkill /F /IM wscript.exe
taskkill /F /IM cscript.exe
TAKEOWN /F "C:\Windows\System32\drivers\etc" /R /D N
cd \
cd "C:\Windows\System32\drivers\etc\
del /s /f /q /a "Hosts"

icacls "C:\Windows\System32\drivers\etc" /reset /T /C
icacls "C:\Windows" /reset /C
taskkill /f /im explorer.exe
start "" "%windir%\explorer.exe"  
