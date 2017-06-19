#!/bin/sh

#set computer name
sudo systemsetup -setcomputername NAME

#set hostname
sudo scutil --set HostName NAME.local

#set sleep schedule to 30 minutes to all power sources
sudo pmset -a displaysleep 30 disksleep 30 sleep 30 womp 1 autorestart 1

#disable user list at login window
sudo defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool true

#add branding at login window
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Property of COMPANY NAME"

#enable fast user switching
sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool true

#hide the local admin
sudo dscl . -create /Users/ADMIN_USER IsHidden 1
if [ -d /Users/ADMIN_USER ]; then
    sudo mv /Users/ADMIN_USER /var/ADMIN_USER
fi
sudo dscl . -create /Users/ADMIN_USER NFSHomeDirectory /var/ADMIN_USER

#disable mac app store auto update
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false

#disable java auto update
sudo defaults write /Library/Preferences/com.oracle.java.Java-Updater JavaAutoUpdateEnabled -bool false

#disable flash auto update
if [ ! -f /Library/Application\ Support/Macromedia/mms.cfg ]; then
mkdir /Library/Application\ Support/Macromedia
touch /Library/Application\ Support/Macromedia/mms.cfg
chmod 644 /Library/Application\ Support/Macromedia/mms.cfg
CONF="/Library/Application Support/Macromedia/mms.cfg"
cat > "${CONF}" << EOF
AutoUpdateDisable=1
SilentAutoUpdateEnable=0
EOF
fi
