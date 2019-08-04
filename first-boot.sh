#!/bin/bash

company_name="Company Name"
admin_user="administrator"
net_time="TIME_SERVER"
ard_kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
dns_servers="0.0.0.0 1.1.1.1"
dns_search="sub1.domain.net sub2.domain.net"
ard_group_name="com.apple.local.ard_admin"
OLDIFS=$IFS; IFS=$'\n'

# get computer name
#computer_name=$(/usr/bin/osascript -e 'display dialog "Computer Name" default answer "John.Smith.001-100-00000001" buttons {"Cancel", "Continue"} default button 2 with title "Client Setup"' -e 'text returned of the result')
#if [[ $computer_name != "" ]]; then
#	/usr/sbin/scutil --set ComputerName $computer_name
#fi

# get host name
#host_name=$(/usr/bin/osascript -e 'display dialog "Host Name" default answer "smi100" buttons {"Cancel", "Continue"} default button 2 with title "Client Setup"' -e 'text returned of the result')
#if [[ $host_name != "" ]]; then
#	/usr/sbin/scutil --set HostName $host_name
#	/usr/sbin/scutil --set LocalHostName $host_name
#fi

# set ard
ard_check=$(/usr/bin/dscl /Local/Default -list /Groups | /usr/bin/grep "$ard_group_name")
if [[ $ard_check == "" ]]; then
	/usr/sbin/dseditgroup -o create -n /Local/Default -r "Apple Remote Desktop Administrators" "$ard_group_name"
	/usr/sbin/dseditgroup -o edit -n /Local/Default -a animation -t user "$ard_group_name"
	if [[ $computer_name != "" ]] && [[ $host_name != "" ]]; then
		ard_text1=$(/bin/echo $computer_name | /usr/bin/grep -o '.\{8\}$')
		ard_text2=$(/bin/echo $computer_name | /usr/bin/cut -d'.' -f'3' | /usr/bin/cut -d'-' -f'1,2')
		ard_text3=$host_name
		$ard_kickstart -quiet -configure -computerinfo -set1 -1 "${ard_text1}" -set2 -2 "${ard_text2}" -set3 -3 "${ard_text3}"
	fi
	$ard_kickstart -quiet -configure -allowAccessFor -specifiedUsers
	$ard_kickstart -activate -configure -setmenuextra -menuextra  no -clientopts -setdirlogins -dirlogins yes
fi

# set dns
for i in $(/usr/sbin/networksetup -listallnetworkservices | /usr/bin/grep 'Ethernet'); do 
	IFS=$OLDIFS
	/usr/sbin/networksetup -setdnsservers "$i" $dns_servers
	/usr/sbin/networksetup -setsearchdomains "$i" $dns_search
done

# set network time
/usr/sbin/systemsetup -setnetworktimeserver $net_time
/usr/sbin/systemsetup -setusingnetworktime on

# set energy saver
/usr/bin/pmset -a displaysleep 15 disksleep 0 sleep 0 powernap 0 autorestart 1 womp 1

# set login options
/usr/bin/defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool true
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool false
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Property of $company_name"

# add all users to _lpoperator
/usr/sbin/dseditgroup -o edit -t group -a everyone _lpoperator

# disable connect to server confirmation
/usr/bin/defaults write /Library/Preferences/com.apple.NetworkAuthorization AllowUnknownServers -bool true

# hide local admin
/usr/bin/dscl /Local/Default -create /Users/$admin_user IsHidden 1
if [[ -d /Users/$admin_user ]]; then
	/bin/mv -f /Users/$admin_user /var/$admin_user
fi
/usr/bin/dscl /Local/Default -create /Users/$admin_user NFSHomeDirectory /var/$admin_user

# disable java and flash auto updates
#/usr/bin/defaults write /Library/Preferences/com.oracle.java.Java-Updater JavaAutoUpdateEnabled -bool false
#if [[ ! -f /Library/Application\ Support/Macromedia/mms.cfg ]]; then
#	/bin/mkdir /Library/Application\ Support/Macromedia
#	/usr/bin/touch /Library/Application\ Support/Macromedia/mms.cfg
#	/bin/echo "AutoUpdateDisable=1" >> /Library/Application\ Support/Macromedia/mms.cfg
#	/bin/echo "SilentAutoUpdateEnable=0" >> /Library/Application\ Support/Macromedia/mms.cfg
#	/bin/chmod 644 /Library/Application\ Support/Macromedia/mms.cfg
#fi

# install munkitools
#install_munki=$(/usr/bin/osascript -e 'display dialog "Would you like to install the Munki client?" buttons {"No", "Yes"} default button 2 with title "Client Setup"' -e 'button returned of the result')
#if [[ $install_munki == "Yes" ]]; then
#	/usr/sbin/installer -pkg /private/tmp/munki_tools.pkg -target /
#	/usr/bin/touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
#fi
#/bin/rm -f /private/tmp/munki_tools.pkg

exit 0
