#!/bin/bash
#Title: Update script for KDE-Neon
#Description: updates system
#Author: Roo79x
#Date: 20 March 2017
#Usage: bash upgcln.sh
##############################

#output text colours
txtblk=$(tput setaf 0) # Black
txtred=$(tput setaf 1) # Red
txtgrn=$(tput setaf 2) # Green
txtylw=$(tput setaf 3) # Yellow
txtblu=$(tput setaf 4) # Blue
txtmag=$(tput setaf 5) # Magenta
txtcyn=$(tput setaf 6) # Cyan
txtwht=$(tput setaf 7) # White
txtbld=$(tput bold) # start bold
txtdim=$(tput dim) # Select dim (half-bright) mode
txtsmul=$(tput smul) # Enable underline mode
txtrmul=$(tput rmul) # Disable underline mode
txtrev=$(tput rev) # Turn on reverse video mode
txtsmso=$(tput smso) # Enter standout (bold) mode
txtrmso=$(tput rmso) # Exit standout mode
txtrst=$(tput sgr0) # Text reset

greet="$(h=`date +%H`

if [ $h -lt 12 ]; then
  echo Good morning
elif [ $h -lt 18 ]; then
  echo Good afternoon
else
  echo Good evening
fi)"

user="${SUDO_USER:-$USER}"

############ UPDATE UPGRADE AND CLEANUP ###################

echo "${txtbld} ${txtmag} "${greet}" "${user}" ${txtrst}"
echo "${txtbld} ${txtblu} ${txtsmul}Running Update Script${txtrmul} ${txtrst}"
echo "  "

sudo -p "${txtbld} ${txtgrn} Please enter your password: ${txtrst}" whoami 1>/dev/null


echo "${txtbld} ${txtund} ${txtgrn} Doing an Update, Upgrade and Cleanup... ${txtrst} ${txtcyn} [Cleanliness is next to Godliness you know!!] ${txtrst}"
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoclean && sudo apt-get -y autoremove --purge
echo "   "

#Finished
echo "    "
echo "${txtbld} ${txtred} END OF LINE... ${txtrst}"
sleep 1s
echo "   "