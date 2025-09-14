@echo off
REM Bridgeport Resource Packaging Script for Windows
REM Creates a bridgeport.zip file ready for txAdmin upload

echo Creating bridgeport resource package...

REM Clean up any existing package directory and zip
if exist bridgeport rmdir /s /q bridgeport
if exist bridgeport.zip del bridgeport.zip

REM Create the package directory structure
mkdir bridgeport
mkdir bridgeport\stream

REM Copy required files to package directory
copy fxmanifest.lua bridgeport\
copy client.lua bridgeport\
copy server.lua bridgeport\
copy locations.lua bridgeport\
copy config.lua bridgeport\
copy stream\bridgeport_draft.ymap bridgeport\stream\

REM Create ZIP file (requires PowerShell 5.0+ or Windows 10+)
powershell -command "Compress-Archive -Path 'bridgeport' -DestinationPath 'bridgeport.zip' -Force"

REM Clean up temporary directory
rmdir /s /q bridgeport

echo.
echo Package created: bridgeport.zip
echo.
echo This ZIP file is ready for upload to txAdmin:
echo 1. Go to txAdmin Resources page
echo 2. Click "Install from ZIP"
echo 3. Upload bridgeport.zip
echo 4. Restart your server
echo.
pause