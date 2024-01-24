#!/usr/bin/env fish

if type -q nmcli
	for INTERFACE in (nmcli device status | awk -F: '{ print $1,$3 }' | grep -w 'connected' | awk '{ print $1 }')
		if type -q ip
			set ip_out (ip a show $INTERFACE | awk 'BEGIN { FS="\n" } { print $1, $2 }' | grep 'inet' | awk 'BEGIN { FS=" " } { print "    "$1,$2 }' | string collect)
		else if type -q ifconfig
			set ip_out (ifconfig $INTERFACE | awk 'BEGIN { FS="\n" } {print $1, $2}' | grep 'inet' | awk 'BEGIN { FS=" " } { print "    "$1,$2 }' | string collect)
		else
			echo 'neither `ifconfig` nor `ip` found :('
		end
		echo $INTERFACE:
		echo $ip_out
	end
else
	echo '`nmcli` not found :('
end

