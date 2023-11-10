#!/bin/bash

sudo -v

# Define temporary file names for the monitor script and plist
TMP_MONITOR_SCRIPT="/tmp/restart_screen_sharing.sh"
TMP_PLIST_FILE="/tmp/com.user.restartscreen.plist"

# Define the final installation paths
FINAL_MONITOR_SCRIPT="/usr/local/bin/restart_screen_sharing.sh"
FINAL_PLIST_FILE=/Library/LaunchDaemons/com.macminivault.restartscreensharing.plist

# Create /usr/local/bin if it doesn't exist
if [ ! -d /usr/local/bin ]; then
    sudo mkdir -p /usr/local/bin
    sudo chmod 755 /usr/local/bin
fi

# Create and write the monitor script to a temporary location
cat << 'EOF' > $TMP_MONITOR_SCRIPT
#!/bin/bash

HOST="localhost"
PORT=5900

if ! nc -z $HOST $PORT; then
    echo "Port $PORT is not responding. Attempting to restart Screen Sharing..."
    sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
    sudo launchctl enable system/com.apple.screensharing
else
    echo "Port $PORT is open. Screen Sharing seems to be running."
fi
EOF

# Create and write the plist file to a temporary location
cat << EOF > $TMP_PLIST_FILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.macminivault.restartscreensharing</string>
    <key>ProgramArguments</key>
    <array>
        <string>$FINAL_MONITOR_SCRIPT</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>300</integer> <!-- Check every 5 minutes -->
</dict>
</plist>
EOF

# Move and set permissions for the monitor script
sudo mv $TMP_MONITOR_SCRIPT $FINAL_MONITOR_SCRIPT
sudo chmod +x $FINAL_MONITOR_SCRIPT

# Move the plist file to the final location
sudo mv $TMP_PLIST_FILE $FINAL_PLIST_FILE

sudo chown root:wheel $FINAL_PLIST_FILE
sudo chmod o-w $FINAL_PLIST_FILE

# Load the plist file
sudo launchctl load $FINAL_PLIST_FILE

# Run the monitor script once to test
$FINAL_MONITOR_SCRIPT

echo "...."
echo "...."
echo "macOS Screen Sharing Monitor script has been installed."
