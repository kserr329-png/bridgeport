#!/bin/bash
# Bridgeport Resource Packaging Script for Linux/Mac
# Creates a bridgeport.zip file ready for txAdmin upload

echo "Creating bridgeport resource package..."

# Clean up any existing package directory and zip
rm -rf bridgeport
rm -f bridgeport.zip

# Create the package directory structure
mkdir -p bridgeport/stream

# Copy required files to package directory
cp fxmanifest.lua bridgeport/
cp client.lua bridgeport/
cp server.lua bridgeport/
cp locations.lua bridgeport/
cp config.lua bridgeport/
cp stream/bridgeport_draft.ymap bridgeport/stream/

# Create ZIP file
if command -v zip &> /dev/null; then
    zip -r bridgeport.zip bridgeport/
else
    echo "Error: 'zip' command not found. Please install zip utility."
    echo "On Ubuntu/Debian: sudo apt-get install zip"
    echo "On CentOS/RHEL: sudo yum install zip"
    echo "On macOS: zip should be available by default"
    exit 1
fi

# Clean up temporary directory
rm -rf bridgeport

echo ""
echo "Package created: bridgeport.zip"
echo ""
echo "This ZIP file is ready for upload to txAdmin:"
echo "1. Go to txAdmin Resources page"
echo "2. Click 'Install from ZIP'"
echo "3. Upload bridgeport.zip"
echo "4. Restart your server"
echo ""