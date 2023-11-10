#!/bin/bash

sudo -v

# Define the installation paths
MONITOR_SCRIPT="/usr/local/bin/restart_screen_sharing.sh"
PLIST_FILE=/Library/LaunchDaemons/com.macminivault.restartscreensharing.plist

sudo launchctl unload $PLIST_FILE
sudo rm $PLIST_FILE
sudo rm $MONITOR_SCRIPT

echo "...."
echo "...."
echo "macOS Screen Sharing Monitor script has been uninstalled."
