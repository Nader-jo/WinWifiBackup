@echo off
chcp 65001 > nul
setlocal disableDelayedExpansion

set "BACKUP_FOLDER=WifiBackup"
set "ZIP_FILE=wifi_backup.zip"

if not exist "%BACKUP_FOLDER%" mkdir "%BACKUP_FOLDER%"

for /f "delims=" %%I in ('netsh wlan show profiles ^| findstr /i "All User Profile"') do (
    call :ExportProfile "%%I"
)

if exist "%ZIP_FILE%" del "%ZIP_FILE%"
tar -a -c -f "%ZIP_FILE%" "%BACKUP_FOLDER%"
echo Backup complete.
exit /b

:ExportProfile
set "line=%~1"
for /f "tokens=1* delims=:" %%a in ("%line%") do set "ssid=%%b"
set "ssid=%ssid:~1%"
netsh wlan export profile name="%ssid%" key=clear folder="%BACKUP_FOLDER%" > nul
goto :eof
