#!/usr/bin/bash

# os-release file

os_release_string='
ID=goth
ID_LIKE=arch
DEFAULT_HOSTNAME="GothicOS"
NAME="Gothic OS"
BUILD_ID=rolling
ANSI_COLOR="38;2;202;206;250"
HOME_URL="https://gothicos.vercel.app/"
LOGO=gothicos-logo
'

echo $os_release_string > /etc/os-release
echo $os_release_string > /usr/lib/os-release

# lsb-release file

lsb_release_string='
DISTRIB_ID="Goth"
DISTRIB_RELEASE="rolling"
DISTRIB_DESCRIPTION="Gothic OS"
'

echo $lsb_release_string > /etc/lsb-release