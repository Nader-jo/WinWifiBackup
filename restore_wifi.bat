@echo off

set "RESTORE_FOLDER=WifiBackup"
set "ZIP_FILE=wifi_backup.zip"

if not exist "%ZIP_FILE%" exit /b

if not exist "%RESTORE_FOLDER%" mkdir "%RESTORE_FOLDER%"

tar -xf "%ZIP_FILE%"

for %%I in ("%RESTORE_FOLDER%\*.xml") do (
    netsh wlan add profile filename="%%~I" >nul
)

echo Restore complete.
pause
