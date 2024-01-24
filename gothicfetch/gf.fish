#!/usr/bin/fish

# hostname
if test -n $hostname
	set g_hostname $hostname
else if test -f /etc/hostname
	set g_hostname (cat /etc/hostname)
else
	set g_hostname '?'
end

# username
if test -n $USER
	set g_username $USER
else if test -n $USERNAME
	set g_username $USERNAME
else
	set g_username '?'
end

# os
if type -q lsb_release
	set g_os (lsb_release -sd | tr -d '"')
else if test -f /etc/os-release
	if grep -Eq '^NAME|PRETTY_NAME' /etc/os-release
		set g_os (grep -E '^NAME=|PRETTY_NAME=' /etc/os-release | awk -F= '{print $2}' | tr -d '"')
	end
else
	set g_os '?'
end

# kernel
if type -q uname
	set g_kernelrel (uname -r)
else
	set g_kernelrel '?'
end

# init system
if type -q ps
	set g_sysinit (ps -p 1 -o comm=)
else
	set g_sysinit '?'
end

# battery
if test -d /sys/class/power_supply/
	set g_bat (grep -E '^POWER_SUPPLY_CAPACITY=' /sys/class/power_supply/*/uevent | awk -F= '{print $2}')%
else
	set g_bat '?'
end

# output
echo ✰ (set_color $fish_color_host_remote --bold)$g_os(set_color $fish_color_normal)
echo (set_color $fish_color_command --bold)init(set_color $fish_color_normal --bold) ⚕ (set_color $fish_color_param --bold)$g_sysinit(set_color $fish_color_normal)
echo (set_color $fish_color_command --bold)kern(set_color $fish_color_normal --bold) ⚕ (set_color $fish_color_param --bold)$g_kernelrel(set_color $fish_color_normal)
echo (set_color $fish_color_command --bold)user(set_color $fish_color_normal --bold) ⚕ (set_color $fish_color_param --bold)$g_username(set_color $fish_color_normal)
echo (set_color $fish_color_command --bold)batt(set_color $fish_color_normal --bold) ⚕ (set_color $fish_color_param --bold)$g_bat(set_color $fish_color_normal)
