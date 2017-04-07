lsb_release -a

---colours-------------------
#ACCD8A --green

#253F4D

#353945

#2F343F
---------------wget----------------------
wget -nv --content-disposition

------------------------------

rm -rf ~/.local/share/Trash/files/*

sudo text-editor-here /usr/share/nautilus/ui/nautilus-navigation-window-ui.xml
________________________________________________________________________


gmail to
https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto

#############################XFCE##########################################


xubuntu lid switch do nothing when closed
/etc/systemd/logind.conf

Date time format for lightdm orage callendar etc
%A %e %B %Y %l:%M %P

crontab for orage calendar
*/5 * * * * /home/roo79x/.local/share/orage/rays-orage-gcalsync.sh

*/6 * * * * /home/roo79x/.local/share/orage/holidays-ics.sh

mail watcher setup
firefox -new-tab http://gmail.com

/usr/bin/google-chrome-stable http://gmail.com

notify-send "New mail" "You have new messages in your inbox" -i xfce-newmail

###.gtkrc-2.0###
style "whisker-menu-numix-dark-blue-theme"
{
base[NORMAL] = "#2B2B2B"
base[ACTIVE] = "#4B5871"
text[NORMAL] = "#ccc"
text[ACTIVE] = "#fff"
bg[NORMAL] = "#2B2B2B"
bg[ACTIVE] = "#4B5871"
bg[PRELIGHT] = "#4B5871"
fg[NORMAL] = "#ccc"
fg[ACTIVE] = "#fff"
fg[PRELIGHT] = "#fff"
}
widget "whiskermenu-window*" style "whisker-menu-numix-dark-blue-theme"

####################################KDE#########################################

How To Fix ROOT Apps Theme in KDE Plasma
Add this line in /etc/environment
XDG_CURRENT_DESKTOP="KDE"



if #Ask user whether they want to install Microsoft fonts
  echo -n "Do you want to install Microsoft TrueType Fonts (y/n)? "
  read -rn1 Fonts  
  echo
  

  #Optional install of Microsoft fonts
  if [[ $Fonts == "y" ]] || [[ $Fonts == "Y" ]]; then
    echo "Installing Microsoft Fonts"
    "${Fonts}"
  fi


#to install ffmulticonverter

wget https://sourceforge.net/projects/ffmulticonv/files/ffmulticonverter-1.8.0.tar.gz

tar -xvzf ffmulticonverter-1.8.0.tar.gz

cd ffmulticonverter-1.8.0/

sudo python3 setup.py install


#to install VLC
Go to Discover (app store) and search for VLC

#Or via commandline

sudo apt-get install vlc vlc-nox

#For a different music player try clementine (most kde users I know use this... But I have never used it)

Go to Discover app store and search for clementine

#Or via commandline

sudo apt-get install clementine

#For Google Chrome (Chrome/Chromium are 64 bit only!)

go to https://www.google.com/chrome/browser/desktop/index.html?platform=linux

Download and install 64 bit .deb (For Debian/Ubuntu) install by gui

#Or via commandline

Download the package

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

Install the package:

sudo dpkg -i google-chrome-stable_current_amd64.deb

Install the package, forcing install of dependencies:

sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

In case any dependencies diddnt install (you would have a warning or failure message for this), you can force them via:

sudo apt-get install -f

###Media Codecs### ubuntu needs extra media codecs to play almost anything. here are the options:
All are via terminal command.

#NeroAac (For aac audio for video / audio encoding and ffmpeg)
	cd /tmp
    wget http://ftp6.nero.com/tools/NeroAACCodec-1.5.1.zip
    unzip -j NeroAACCodec-1.5.1.zip linux/neroAac*
    sudo install -m 0755 neroAacEnc /usr/bin/
    sudo install -m 0755 neroAacDec /usr/bin/
    sudo install -m 0755 neroAacTag /usr/bin/
    cd

#Install Some Extra Media Codecs Without Flash!!! (FLASH BAD!!!) *RECOMMENDED
sudo apt install lame gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-fluendo-mp3 libdvdread4 oxideqt-codecs-extra libavcodec-extra libavcodec-extra57 ffmpeg aac-enc libav-tools mediainfo vorbis-tools opus-tools vpx-tools x264 x265 mkvtoolnix ffmpeg2theora sox libc6-i386 lib32gcc1 lib32stdc++6 gpac

#Install Some Extra Microsoft true type fonts and Media Codecs With Flash!!! (FLASH BAD - FLASH VERY BAD - BAD FLASH... NO!!!) *NOT RECOMMENDED
sudo apt-get install kubuntu-restricted-extras kubuntu-restricted-addons

#######################bash########################
##setup template 001#####

#!/bin/bash
#Title: script
#Description: is a bash script
#Author: Roo79x
#Date: some-date
#Usage: bash script
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

#Post Install
echo "${txtbld} ${txtmag} "${greet}" "${user}" ${txtrst}"
echo "${txtbld} ${txtblu} ${txtsmul}Running Update Script${txtrmul} ${txtrst}"
echo "  "

sudo -p "${txtbld} ${txtgrn} Please enter your password: ${txtrst}" whoami 1>/dev/null


#######################end bash template##################


#alias pkexec='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'


#####################roo-urls######################

##Github
https://github.com/roo79x/my-script-n-stuff

# launchpad.net
https://launchpad.net/~roo79x/

## my PPA

https://launchpad.net/~roo79x/+archive/ubuntu/my-kde

## To install

sudo add-apt-repository ppa:roo79x/my-kde
sudo apt-get update
