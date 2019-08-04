#!/bin/bash

local_admin="administrator"
desktop_picture="/Users/Shared/picture.png"
company_plist="com.company.division.setup"

/bin/sleep 2

completed_setup=$(/usr/bin/defaults read $company_plist SetupComplete 2> /dev/null)
if [[ $completed_setup -ne '1' ]]; then
	# set finder and desktop options
	/usr/bin/defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	/usr/bin/defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
	/usr/bin/defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	/usr/bin/defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
	/usr/bin/defaults write com.apple.finder ShowStatusBar -bool true
	/usr/bin/defaults write com.apple.finder ShowPathbar -bool true
	/usr/bin/defaults write com.apple.finder FinderSpawnTab -bool false
	/usr/bin/defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
	/usr/bin/osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$desktop_picture"'
	
	# menu bar items
	/usr/bin/defaults write com.apple.airplay showInMenuBarIfPresent -bool false
	/usr/bin/defaults write com.citrix.receiver.nomas ShowHelperInMenuBar -bool false
	/usr/bin/defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airport" -bool false
	/usr/bin/defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.eject" -bool false
	/usr/bin/defaults write com.apple.systemuiserver menuExtras -array \
		"/System/Library/CoreServices/Menu Extras/Clock.menu" \
		"/System/Library/CoreServices/Menu Extras/User.menu"
	/usr/bin/defaults -currentHost write com.apple.systemuiserver dontAutoLoad -array \
		"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
		"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
		"/System/Library/CoreServices/Menu Extras/Displays.menu" \
		"/System/Library/CoreServices/Menu Extras/DwellControl.menu" \
		"/System/Library/CoreServices/Menu Extras/Eject.menu" \
		"/System/Library/CoreServices/Menu Extras/ExpressCard.menu" \
		"/System/Library/CoreServices/Menu Extras/iChat.menu" \
		"/System/Library/CoreServices/Menu Extras/Ink.menu" \
		"/System/Library/CoreServices/Menu Extras/IrDA.menu" \
		"/System/Library/CoreServices/Menu Extras/PPP.menu" \
		"/System/Library/CoreServices/Menu Extras/PPPoE.menu" \
		"/System/Library/CoreServices/Menu Extras/RemoteDesktop.menu" \
		"/System/Library/CoreServices/Menu Extras/SafeEjectGPUExtra.menu" \
		"/System/Library/CoreServices/Menu Extras/Script Menu.menu" \
		"/System/Library/CoreServices/Menu Extras/TextInput.menu" \
		"/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
		"/System/Library/CoreServices/Menu Extras/UniversalAccess.menu" \
		"/System/Library/CoreServices/Menu Extras/VPN.menu" \
		"/System/Library/CoreServices/Menu Extras/Volume.menu" \
		"/System/Library/CoreServices/Menu Extras/WWAN.menu"
		#"/System/Library/CoreServices/Menu Extras/Battery.menu"
		#"/System/Library/CoreServices/Menu Extras/Clock.menu"
		#"/System/Library/CoreServices/Menu Extras/User.menu"
		
	# enable full save and print options
	/usr/bin/defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	/usr/bin/defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
	/usr/bin/defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
	/usr/bin/defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
	
	# disable smart quotes and smart dashes
	/usr/bin/defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	/usr/bin/defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	
	# disable natural mouse scroll
	/usr/bin/defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
	
	# enable screen lock
	/usr/bin/defaults write com.apple.screensaver askForPassword -bool true
	/usr/bin/defaults write com.apple.screensaver askForPasswordDelay -int 1
	
	# disable google auto update
	/usr/bin/defaults write com.google.Keystone.Agent checkInterval 0
	
	# disable slack auto updates
	/usr/bin/defaults write com.tinyspeck.slackmacgap SlackNoAutoUpdates -bool true
	
	# disable apple menu items
	# /usr/bin/defaults write com.apple.loginwindow RestartDisabledWhileLoggedIn -bool true
	# /usr/bin/defaults write com.apple.loginwindow ShutDownDisabledWhileLoggedIn -bool true
	
	# set dock items
	dockutil="/usr/local/bin/dockutil"
	if [[ $USER != $local_admin ]]; then
		/usr/bin/defaults write com.apple.dock autohide -bool false
		/usr/bin/defaults write com.apple.dock orientation bottom
		/usr/bin/defaults write com.apple.dock magnification -bool true
		/usr/bin/defaults write com.apple.dock show-recents -bool false
		/usr/bin/defaults write com.apple.dock tilesize -int 35
		/usr/bin/defaults write com.apple.dock largesize -int 90
		#/usr/bin/defaults write com.apple.dock dock-extra -bool true
		#/usr/bin/defaults write com.apple.dock size-immutable -bool true
		#/usr/bin/defaults write com.apple.dock contents-immutable -bool true
		$dockutil --remove all --no-restart
		$dockutil --add /Applications/Safari.app --no-restart
		$dockutil --add /Applications/Firefox.app --no-restart
		$dockutil --add /Applications/Google\ Chrome.app --no-restart
		$dockutil --add /Applications/Adobe\ Bridge\ CC\ 2019/Adobe\ Bridge\ 2019.app --no-restart
		$dockutil --add /Applications/Adobe\ Illustrator\ CC\ 2019/Adobe\ Illustrator.app --no-restart
		$dockutil --add /Applications/Adobe\ InDesign\ CC\ 2019/Adobe\ InDesign\ CC\ 2019.app --no-restart
		$dockutil --add /Applications/Adobe\ Photoshop\ CC\ 2019/Adobe\ Photoshop\ CC\ 2019.app --no-restart
		$dockutil --add /Applications/Microsoft\ Excel.app --no-restart
		$dockutil --add /Applications/Microsoft\ Outlook.app --no-restart
		$dockutil --add /Applications/Microsoft\ PowerPoint.app --no-restart
		$dockutil --add /Applications/Microsoft\ Teams.app --no-restart
		$dockutil --add /Applications/Microsoft\ Word.app --no-restart
		$dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
		$dockutil --add '~/Downloads' --view list --display folder --sort dateadded
	fi
	if [[ $USER == $local_admin ]]; then
		/usr/bin/defaults write com.apple.dock autohide -bool false
		/usr/bin/defaults write com.apple.dock orientation bottom
		/usr/bin/defaults write com.apple.dock magnification -bool true
		/usr/bin/defaults write com.apple.dock show-recents -bool false
		/usr/bin/defaults write com.apple.dock tilesize -int 35
		/usr/bin/defaults write com.apple.dock largesize -int 90
		$dockutil --remove all --no-restart
		$dockutil --add /Applications/Safari.app --no-restart
		$dockutil --add /Applications/Utilities/Console.app --no-restart
		$dockutil --add /System/Library/CoreServices/Applications/Network\ Utility.app --no-restart
		$dockutil --add /Applications/Utilities/Disk\ Utility.app --no-restart
		$dockutil --add /System/Library/CoreServices/Applications/Directory\ Utility.app --no-restart
		$dockutil --add /Applications/Utilities/Activity\ Monitor.app --no-restart
		$dockutil --add /Applications/Utilities/Terminal.app --no-restart
	fi
	
	# set firefox
	firefox="$HOME/Library/Application Support/Firefox"
	if [[ -d "$firefox" ]]; then
		/bin/mv -f "$firefox" "$firefox $(/bin/date '+%Y-%m-%d_%H-%M-%S')"
	fi
	/Applications/Firefox.app/Contents/MacOS/firefox -CreateProfile default
	/usr/bin/open /Applications/Firefox.app
	/usr/bin/killall 'firefox'
	for i in $(/bin/ls "$firefox/Profiles/"); do
		user_js="$firefox/Profiles/$i/user.js"
		/bin/echo "user_pref(\"app.update.enabled\", false);" >> "$user_js"
		/bin/echo "user_pref(\"app.update.auto\", false);" >> "$user_js"
		/bin/echo "user_pref(\"app.update.mode\", 0);" >> "$user_js"
		/bin/echo "user_pref(\"app.update.service.enabled\", false);" >> "$user_js"
		/bin/echo "user_pref(\"browser.startup.homepage\", \"https://behindtheshield.warnerbros.com\");" >> "$user_js"
		/bin/echo "user_pref(\"browser.startup.homepage_override.mstone\", \"ignore\");" >> "$user_js"
		/bin/echo "user_pref(\"browser.rights.3.shown\", true);" >> "$user_js"
	done
	
	# set acrobat pro as default pdf handler
	if [[ $USER != $local_admin ]]; then
		array_index='0'
		launchserv_plist="$HOME/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist"
		handler_check=$(/usr/bin/defaults read $launchserv_plist LSHandlers | /usr/bin/grep "com.adobe.acrobat.pro")
		if [[ $handler_check == "" ]]; then
			/usr/libexec/PlistBuddy -c "Print LSHandlers:$array_index" $launchserv_plist &> /dev/null
			while [[ $? -eq '0' ]]; do
				((array_index++))
				/usr/libexec/PlistBuddy -c "Print LSHandlers:$array_index" $launchserv_plist &> /dev/null
			done
			/usr/libexec/PlistBuddy -c "Add LSHandlers array" $launchserv_plist &> /dev/null
			/usr/libexec/PlistBuddy -c "Add LSHandlers:$array_index:LSHandlerContentType string com.adobe.pdf" $launchserv_plist
			/usr/libexec/PlistBuddy -c "Add LSHandlers:$array_index:LSHandlerPreferredVersions dict" $launchserv_plist
			/usr/libexec/PlistBuddy -c "Add LSHandlers:$array_index:LSHandlerPreferredVersions:LSHandlerRoleAll string -" $launchserv_plist
			/usr/libexec/PlistBuddy -c "Add LSHandlers:$array_index:LSHandlerRoleAll string com.adobe.acrobat.pro" $launchserv_plist
		fi
	fi
	
	# set outlook
	#current_usr_id=$(/usr/bin/dscl . -read /Users/$USER UniqueID | /usr/bin/awk '{print $2}')
	#if [[ "$current_usr_id" -gt '1000' ]]; then
	#	completed_outlook=$(/usr/bin/defaults read $company_plist OutlookComplete 2> /dev/null)
	#	if [[ $completed_outlook -ne '1' ]]; then
	#		/usr/bin/osascript /usr/local/wba/outlook/outlook_account_setup.scpt
	#		/usr/bin/defaults write $company_plist OutlookComplete -bool true
	#	fi
	#fi
	
	# reset
	/usr/bin/killall 'Finder'
	
	# open enterprise connect
	if [[ $USER != $local_admin ]]; then
		/usr/bin/open /Applications/Enterprise\ Connect.app
	fi
	
	# write setup done
	/usr/bin/defaults write $company_plist SetupComplete -bool true
fi

exit 0
