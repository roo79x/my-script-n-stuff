#!/bin/bash
#Title: Post install script for KDE-Neon
#Description: Installs patent encumbered audio and video codecs WITHOUT FLASH!!
#Author: Roo79x
#Date: 20 March 2017
#Usage: bash kubuntu16.10-postinstall-coop-150317.sh
## Some parts of this script are copied from Quidsup's flashless-extras.sh 
script found at https://github.com/quidsup/flashless-extras
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
echo "${txtbld} ${txtblu} ${txtsmul}Running Kubuntu Post Install 
Script${txtrmul} ${txtrst}"
echo "  "

sudo -p "${txtbld} ${txtgrn} Please enter your password: ${txtrst}" whoami 
1>/dev/null

echo "Updating repositories"
sudo apt update
echo 

# echo "${txtbld} ${txtylw} Removing Unwanted Applications ${txtrst}"
# sudo apt-get autoremove --purge kwrite gwenview
# echo "   "

echo "${txtbld} ${txtblu} Now we will install some extra PPAs ${txtrst}"

read -p "${txtbld} ${txtblu} Add Kubuntu Backports PPA? (Y/N) ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository ppa:kubuntu-ppa/backports
fi

read -p "${txtbld} ${txtblu} Add LibreOffice PPA? (Y/N) (most current version of 
Libreoffice) ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository ppa:libreoffice/ppa
fi

read -p "${txtbld} ${txtblu} Add NoMacs Image Viewer PPA? (Y/N) ${txtrst}" -n 1 
-r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:nomacs/stable
fi

read -p "${txtbld} ${txtblu} Add SMPlayer PPA? (Y/N) (For SMTube Youtube 
Downloader and SMplayer MPV Frontend) ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository ppa:rvm/smplayer
fi

read -p "${txtbld} ${txtblu} Add FFMPEG 3 PPA? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:jonathonf/ffmpeg-3
fi

echo "${txtbld} ${txtcyn} Do an update to add the new PPA's ${txtrst}"
sudo apt-get -y update && sudo apt-get upgrade

echo "  "

#yt-dl
echo "${txtbld} ${txtgrn} Installing youtube-dl ${txtrst}"
echo "${txtbld} ${txtgrn} Checking if youtube-dl is installed already${txtrst}"
file="/usr/local/bin/youtube-dl"
if [ -e "$file" ]
then
    echo "${txtbld} ${txtgrn} Found youtube-dl ${txtrst}"
	sudo youtube-dl -U
else
    echo "${txtbld} ${txtgrn} Not Found so downloading and installing youtube-dl 
${txtrst}"
	sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O 
/usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
sleep 1s
fi

#NeroAac
echo "${txtbld} ${txtgrn} Installing NeroAac ${txtrst}"
echo "${txtbld} ${txtgrn} Checking if NeroAac is installed already${txtrst}"
file="/usr/bin/neroAacEnc"
if [ -e "$file" ]
then
    echo "${txtbld} ${txtgrn} NeroAac is already installed ${txtrst}"

else
    echo "${txtbld} ${txtgrn} Downloading and installing NeroAac ${txtrst}"
    cd /tmp
    wget http://ftp6.nero.com/tools/NeroAACCodec-1.5.1.zip
    unzip -j NeroAACCodec-1.5.1.zip linux/neroAac*
    sudo install -m 0755 neroAacEnc /usr/bin/
    sudo install -m 0755 neroAacDec /usr/bin/
    sudo install -m 0755 neroAacTag /usr/bin/
    cd
    sleep 1s
fi

echo "${txtbld} ${txtylw} Install Some Extra Applications ${txtrst}"
sudo apt install p7zip p7zip-full p7zip-rar unzip zip rar unrar rsync ppa-purge realpath hunspell-en-au
echo "   "

echo "${txtbld} ${txtylw} Install Some Extra Media Codecs Without Flash 
${txtrst}"
sudo apt install lame gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-fluendo-mp3 libdvdread4 oxideqt-codecs-extra libavcodec-extra libavcodec-extra57 ffmpeg aac-enc libav-tools mediainfo vorbis-tools opus-tools vpx-tools x264 x265 mkvtoolnix ffmpeg2theora sox libc6-i386 lib32gcc1 lib32stdc++6 gpac vlc vlc-plugin-samba
echo "   "

echo "${txtbld} ${txtylw} Install Some Extra Applications 
(--no-install-recommends)${txtrst}"
sudo apt --no-install-recommends install synaptic
echo "   "

echo "${txtbld} ${txtcyn} Doing a Final Update, Upgrade and 
Cleanup...[Cleanliness is next to Godliness you know!!] ${txtrst}"
sleep 2s
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo 
apt-get autoclean && sudo apt-get autoremove --purge

#Finished
echo "    "
echo "${txtbld} ${txtred} END OF LINE... ${txtrst}"
sleep 2s
echo "   "
