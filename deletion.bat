
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /f  
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /f

attrib -s -h "C:\Windows\System32\drivers\etc\hosts"
attrib -s -h "C:\Windows\System32\drivers\etc"
taskkill /f /im timeout.exe
taskkill /f /im tor.exe
nircmd exec hide "C:\Program Files\RDP Wrapper\uninstall.bat"
rmdir /s /q "C:\Program Files\RDP Wrapper"
rmdir /s /q "C:\Tor"
Taskkill /f /im winrun.exe
del /s /f /q /a "%Temp%"
del /s /f /q /a "C:\Windows\Win32\*.bat"
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

