#!/bin/bash
#Title: Post install script for KDE-Neon
#Description: Installs patent encumbered audio and video codecs WITHOUT FLASH!!and other stuff
#Author: Roo79x
#Date: 04 April 2017
#Usage: bash kde-neon-postinstall-0417.sh
## Some parts of this script are copied from Quidsup's flashless-extras.sh
#script found at https://github.com/quidsup/flashless-extras
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
echo "${txtbld} ${txtblu} ${txtsmul}Running KDE-NEON Post Install Script${txtrmul} ${txtrst}"
echo "  "

sudo -p "${txtbld} ${txtgrn} Please enter your password: ${txtrst}" whoami 1>/dev/null

echo "${txtbld} ${txtcyn} "Updating repositories" ${txtrst}"
sudo apt update
echo 

echo "${txtbld} ${txtylw} Removing Unwanted Applications ${txtrst}"
sudo apt-get autoremove --purge kwrite gwenview
sleep 1s
echo "   "

echo "${txtbld} ${txtblu} Now we will install some extra PPAs ${txtrst}"

read -p "${txtbld} ${txtblu} Add NoMacs Image Viewer PPA? (Y/N) ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:nomacs/stable
fi

read -p "${txtbld} ${txtblu} Add Ray's Personal PPA? (Y/N) ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:roo79x/my-kde
fi

read -p "${txtbld} ${txtblu} Add FFMPEG 3 PPA? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:jonathonf/ffmpeg-3
fi

#read -p "${txtbld} ${txtblu} Add Kubuntu Backports PPA? (Y/N) ${txtrst}" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#   sudo add-apt-repository ppa:kubuntu-ppa/backports
#fi

#read -p "${txtbld} ${txtblu} Add LibreOffice PPA? (Y/N) (most current version of Libreoffice) ${txtrst}" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#   sudo add-apt-repository ppa:libreoffice/ppa
#fi

#read -p "${txtbld} ${txtblu} Add SMPlayer PPA? (Y/N) (For SMTube Youtube Downloader and SMplayer MPV Frontend) ${txtrst}" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#   sudo add-apt-repository ppa:rvm/smplayer
#fi

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
    echo "${txtbld} ${txtgrn} Not Found so downloading and installing youtube-dl ${txtrst}"
	sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
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

#to install ffmulticonverter
echo "${txtbld} ${txtylw} install ffmulticonverter ${txtrst}"
wget https://sourceforge.net/projects/ffmulticonv/files/ffmulticonverter-1.8.0.tar.gz
tar -xvzf ffmulticonverter-1.8.0.tar.gz
cd ffmulticonverter-1.8.0/
sudo python3 setup.py install
cd
sudo rm -rf ffmulticonverter-1.8.0/
echo "   "

echo "${txtbld} ${txtylw} Install Some Extra Applications ${txtrst}"
sudo apt install p7zip p7zip-full p7zip-rar unzip zip rar unrar rsync ppa-purge realpath hunspell-en-au kate chromium-browser yarock transmission-qt kdesudo lame gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0 libav gstreamer1.0-fluendo-mp3 libdvdread4 oxideqt-codecs-extra libavcodec-extra libavcodec-extra57 ffmpeg aac-enc libav-tools mediainfo vorbis-tools opus-tools vpx-tools x264 x265 mkvtoolnix ffmpeg2theora sox libc6-i386 lib32gcc1 lib32stdc++6 gpac chromium-codecs-ffmpeg-extra ffmpegthumbs libvlc5 phonon4qt5-backend-vlc phonon-backend-vlc vlc vlc-nox vlc-plugin-samba libvlc5 libphonon4qt5-4 python3-pyqt5
echo "   "

echo "${txtbld} ${txtylw} Install Some Extra Applications (--no-install-recommends)${txtrst}"
sudo apt --no-install-recommends install synaptic
echo "   "

echo "${txtbld} ${txtblu} Modding File Manager & Dock!!!............. ${txtrst}"
mkdir ~/temp
sleep 1s
echo "  "

echo "${txtbld} ${txtblu} Modding Chromium browser ${txtrst}"
sudo wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/desktop-files/chromium-browser.desktop -O /usr/share/applications/chromium-browser.desktop
sudo chmod a+rx /usr/share/applications/chromium-browser.desktop
echo "    "

echo "${txtbld} ${txtblu} Modding Dolphin ${txtrst}"
sudo wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/desktop-files/org.kde.dolphin.desktop -O /usr/share/applications/org.kde.dolphin.desktop
sudo chmod a+rx /usr/share/applications/org.kde.dolphin.desktop
echo "    "

echo "${txtbld} ${txtblu} Modding Kate ${txtrst}"
sudo wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/desktop-files/org.kde.kate.desktop -O /usr/share/applications/org.kde.kate.desktop
sudo chmod a+rx /usr/share/applications/org.kde.kate.desktop
echo "    "

echo "${txtbld} ${txtblu} Modding Konsole ${txtrst}"
sudo wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/desktop-files/org.kde.konsole.desktop -O /usr/share/applications/org.kde.konsole.desktop
sudo chmod a+rx /usr/share/applications/org.kde.konsole.desktop
echo "    "

echo "${txtbld} ${txtgrn} Adding Some Custom Scripts ${txtrst}"
mkdir ~/.bin
sudo wget https://www.dropbox.com/s/el4sbhhw610sv09/my01delete-trash-script.sh -O /usr/local/bin/delete-trash
sudo chmod a+rx /usr/local/bin/delete-trash
sudo wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/upgcln.sh -O /usr/local/bin/upgcln
sudo chmod a+rx /usr/local/bin/upgcln
echo "   "

echo "${txtbld} ${txtgrn} Adding Some Extra Eye Candy ${txtrst}"
mkdir ~/temp/Wallpapers
mkdir ~/temp/userpix
wget https://www.dropbox.com/s/cusrakmofqlg4jw/Wallpapers.tar.gz -O ~/temp/Wallpapers.tar.gz
wget https://www.dropbox.com/s/cz8vm5b35zy6lns/userpix.tar.gz -O ~/temp/userpix.tar.gz
tar xzvf ~/temp/Wallpapers.tar.gz -C ~/temp/Wallpapers
tar xzvf ~/temp/userpix.tar.gz -C ~/temp/userpix
sudo mv -f ~/temp/Wallpapers/ /usr/share/wallpapers/
sudo mv -f ~/temp/userpix/ /usr/share/user-manager/avatars/userpix/
echo " "
sleep 1s

echo "${txtbld} ${txtgrn} Training Some Dragons ${txtrst}"
wget https://gist.githubusercontent.com/d0od88/e59f38549d0b990d6fdd2d6d569cd25c/raw/dd4ec483938b4dd50f306c6321984c02935977fc/lattedockinstallation.sh  -O ~/Public/lattedockinstallation.sh
wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/useful-stuff.sh -O ~/Public/useful-stuff.sh
wget https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/kde-neon-postinstall-0417.sh -O ~/Public/kde-neon-postinstall-0417.sh
echo "   "

echo "${txtbld} ${txtgrn} Feeding the Sharks ${txtrst}"
cd
mv ~/Videos ~/Movies
sed -i 's/Videos/Movies/g' ~/.config/user-dirs.dirs
cp ~/.bashrc ~/.bashrc.old
sudo xdg-user-dirs-update
echo 'alias pkexec=pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY' >> ~/.bashrc

echo "${txtbld} ${txtcyn} Doing a Final Update, Upgrade and 
Cleanup...[Cleanliness is next to Godliness you know!!] ${txtrst}"
sleep 2s
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoclean && sudo apt-get autoremove --purge

#Finished
echo "    "
echo "${txtbld} ${txtred} END OF LINE... ${txtrst}"
sleep 1s
echo "   "
