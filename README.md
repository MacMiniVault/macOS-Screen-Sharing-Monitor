# macOS-Screen-Sharing-Monitor
Automatically checks to make sure Screen Sharing is running every 5 minutes. If not, Screen Sharing will be restarted.

**Important: do not run code that you do not trust.**

This script will not work if:

- A firewall is running that does not allow access to port 5900 even from localhost
- Screen Sharing is running on a port other than 5900 (but the script can be manually edited and installed to make this work)
- ARD / Remote Management is being used instead of Screen Sharing
- macOS 10.15 or older is installed on the system

This script will:

- Install a bash script in /usr/local/bin that checks to see if port 5900 is responding. If not, it restarts Screen Sharing
- Install a plist file in /Library/LaunchDaemons that will run every 5 minutes

To install, run:
```
bash <(curl -Ls https://raw.githubusercontent.com/MacMiniVault/macOS-Screen-Sharing-Monitor/main/install.sh)
```

To uninstall, run:
```
bash <(curl -Ls https://raw.githubusercontent.com/MacMiniVault/macOS-Screen-Sharing-Monitor/main/uninstall.sh)
```
