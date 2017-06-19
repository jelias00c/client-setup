#!/bin/sh
# setup desktop environment for new user
# requires dockutil

# set dock icons
/usr/local/bin/dockutil --add '/Applications' --before 'Downloads' --view grid --display folder
/usr/local/bin/dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ Word.app --after 'Keynote'
/usr/local/bin/dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ Excel.app --after 'Keynote'
/usr/local/bin/dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ PowerPoint.app --after 'Keynote'
/usr/local/bin/dockutil --add /Applications/Microsoft\ Office\ 2011/Microsoft\ Outlook.app --after 'Keynote'
/usr/local/bin/dockutil --add /Applications/Managed\ Software\ Center.app --position end
/usr/local/bin/dockutil --remove 'Notes'
/usr/local/bin/dockutil --remove 'Reminders'
/usr/local/bin/dockutil --remove 'Messages'
/usr/local/bin/dockutil --remove 'FaceTime'
/usr/local/bin/dockutil --remove 'Mail'
/usr/local/bin/dockutil --remove 'Contacts'
/usr/local/bin/dockutil --remove 'Maps'
/usr/local/bin/dockutil --remove 'iBooks'
/usr/local/bin/dockutil --remove 'App Store'
/usr/local/bin/dockutil --remove 'System Preferences'

# dock settings
defaults write com.apple.dock.plist autohide -bool false
defaults write com.apple.dock.plist orientation bottom
defaults write com.apple.dock.plist contents-immutable -bool true
defaults write com.apple.dock.plist magnification -bool false
defaults write com.apple.dock.plist size-immutable -bool true
defaults write com.apple.dock.plist dock-extra -bool true

###########################################

# set desktop device visibility
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

###########################################

# enable snap to grid
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# enable full save options
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# enable full print options
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# enable finder status bar
defaults write com.apple.finder ShowStatusBar -bool true

# disable open finder folders in new tabs instead of windows
defaults write com.apple.finder	FinderSpawnTab -bool false

# enable screensaver password after sleep
defaults write com.apple.screensaver askForPassword -int 1

# disable google auto update
defaults write com.google.Keystone.Agent checkInterval 0

# disable screen saver
defaults -currentHost write com.apple.screensaver idleTime 0

# hide citrix menu item
defaults write com.citrix.receiver.nomas ShowHelperInMenuBar -bool false

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###########################################

# remove restart from the apple menu
# defaults write com.apple.loginwindow RestartDisabledWhileLoggedIn -bool true

# remove shutdown from the apple menu
# defaults write com.apple.loginwindow ShutDownDisabledWhileLoggedIn -bool true
