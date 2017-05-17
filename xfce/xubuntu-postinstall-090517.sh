#!/bin/bash
#Title: Post install script for Xubuntu-Core
#Description: Custom / Personal Post install script for Xubuntu
#Author: Roo79x
#Date: 04 April 2017
#Usage: bash xubuntu-postinstall-090517.sh
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
echo "${txtbld} ${txtblu} ${txtsmul}Running Xubuntu Post Install Script${txtrmul} ${txtrst}"
echo "  "

sudo -p "${txtbld} ${txtgrn} Please enter your password: ${txtrst}" whoami 1>/dev/null

echo "${txtbld} ${txtcyn} "enable ubuntu partner repositories" ${txtrst}"
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
echo 

echo "${txtbld} ${txtcyn} "Updating repositories" ${txtrst}"
sudo apt update
echo 

echo "${txtbld} ${txtylw} Removing Unwanted Applications ${txtrst}"
sudo apt-get autoremove --purge onboard pidgin* thunderbird* sgt-puzzles firefox gnome-orca ristretto parole gnome-mines gnome-sudoku xfce4-notes catfish* xfce4-cpugraph-plugin xfce4-places-plugin xfce4-verve-plugin xfce4-weather-plugin xfce4-systemload-plugin xfce4-netload-plugin xfce4-xkb-plugin gnome-software #indicator-messages
sleep 1s
echo "   "

echo "${txtbld} ${txtblu} Now we will install some extra PPAs ${txtrst}"

read -p "${txtbld} ${txtblu} Add Xubuntu Staging PPA? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:xubuntu-dev/xubuntu-staging
fi

read -p "${txtbld} ${txtblu} Add Xubuntu Extras PPA? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:xubuntu-dev/extras
fi

read -p "${txtbld} ${txtblu} Add Docky/Plank Testing PPA? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:ricotz/docky
fi

read -p "${txtbld} ${txtblu} Add Lollypop Music Player? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository -y ppa:gnumdk/lollypop
fi

read -p "${txtbld} ${txtblu} Add Selene Media Encoder? ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo apt-add-repository -y ppa:teejee2008/ppa
fi

read -p "${txtbld} ${txtblu} Add LibreOffice PPA? (Y/N) (most current version of Libreoffice) ${txtrst}" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   sudo add-apt-repository ppa:libreoffice/ppa
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

echo "${txtbld} ${txtylw} Install Some Extra Packages ${txtrst}"
sudo apt-get install synaptic gparted p7zip p7zip-full p7zip-rar unzip zip rar unrar gksu git ntp ppa-purge exfat-fuse exfat-utils ntfs-3g
echo "   "

read -p "${txtbld} ${txtylw} Install Some Extra Applications ${txtrst}" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
sudo apt install plank chromium-browser selene rsync realpath hunspell-en-au lame gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-fluendo-mp3 libdvdread4 libavcodec-extra libavcodec-extra57 ffmpeg aac-enc libav-tools mediainfo vorbis-tools opus-tools vpx-tools x264 x265 mkvtoolnix ffmpeg2theora sox libc6-i386 lib32gcc1 lib32stdc++6 gpac chromium-codecs-ffmpeg-extra intel-microcode libav-tools
fi
echo "   "

echo "${txtbld} ${txtgrn} Installing libdvdread4 ${txtrst}"
sudo /usr/share/doc/libdvdread4/install-css.sh
sleep 1s
echo "  "

echo "${txtbld} ${txtylw} Install Some Extra Applications (--no-install-recommends)${txtrst}"
sudo apt --no-install-recommends install desktop-webmail #lollypop
echo "   "

echo "${txtbld} ${txtblu} Modding File Manager & Dock!!!............. ${txtrst}"
mkdir ~/Public/temp
cd ~/Public/temp
sleep 1s
echo "  "

#echo "${txtbld} ${txtblu} Modding browser ${txtrst}"
#read -p "${txtbld} ${txtblu} Will you be using Firefox or Chrome/ium? Y/y for chrome N/n Firefox${txtrst}" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/linux/general/Desktop-files/google-chrome.desktop
#sudo chmod a+rx ~/Public/temp/google-chrome.desktop
#sudo cp -r ~/Public/temp/google-chrome.desktop /usr/share/applications/
#else
#wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/Desktop-files/firefox.desktop
#sudo chmod a+rx ~/Public/temp/firefox.desktop
#sudo cp -r ~/Public/temp/firefox.desktop /usr/share/applications/
#fi
#echo "    "

echo "${txtbld} ${txtblu} Modding Desktop-Webmail ${txtrst}"
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/Desktop-files/desktop-webmail.desktop
chmod a+rx ~/Public/temp/desktop-webmail.desktop
sudo cp -r ~/Public/temp/desktop-webmail.desktop /usr/share/applications/
echo "    "

echo "${txtbld} ${txtblu} Modding Mousepad ${txtrst}"
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/mousepad.desktop
chmod a+rx ~/Public/temp/mousepad.desktop
sudo cp -r ~/Public/temp/mousepad.desktop /usr/share/applications/
echo "    "

echo "${txtbld} ${txtblu} Modding Thunar ${txtrst}"
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/thunar/exo-file-manager.desktop
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/thunar/Thunar.desktop
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/thunar/Thunar-folder-handler.desktop
chmod a+rx ~/Public/temp/exo-file-manager.desktop
chmod a+rx ~/Public/temp/Thunar-folder-handler.desktop
chmod a+rx ~/Public/temp/Thunar.desktop
sudo cp -r ~/Public/temp/exo-file-manager.desktop /usr/share/applications/
sudo cp -r ~/Public/temp/Thunar-folder-handler.desktop /usr/share/applications/
sudo cp -r ~/Public/temp/Thunar.desktop /usr/share/applications/
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/thunar/thunar-settings.desktop
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/thunar/uca.xml
chmod a+rx ~/Public/temp/thunar-settings.desktop
sudo cp -r ~/Public/temp/thunar-settings.desktop /usr/share/applications/
sudo cp -r ~/Public/temp/uca.xml ~/.config/Thunar/
echo "    "

echo "${txtbld} ${txtblu} Modding xfce4-terminal ${txtrst}"
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/xfce4-terminal.desktop
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/xfce/exo-terminal-emulator.desktop
chmod a+rx ~/Public/temp/exo-terminal-emulator.desktop
chmod a+rx ~/Public/temp/xfce4-terminal.desktop
sudo cp -r ~/Public/temp/exo-terminal-emulator.desktop /usr/share/applications/
sudo cp -r ~/Public/temp/xfce4-terminal.desktop /usr/share/applications/
cd
echo "    "

echo "${txtbld} ${txtgrn} Adding Some Custom Scripts ${txtrst}"
mkdir ~/.scripts
cd ~/.scripts
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/scripts/rays-orage-gcalsync.sh
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/scripts/holidays-ics.sh
#wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/scripts/my01delete-trash-script.sh
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/scripts/extract-mp3/extract-mp3.sh
#wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Linux/general/scripts/Extract-Audio
#chmod a+rx my01delete-trash-script.sh
chmod a+rx extract-mp3.sh
#chmod a+rx Extract-Audio
chmod a+rx rays-orage-gcalsync.sh
chmod a+rx holidays-ics.sh
cd
sudo wget -nc https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/xfce/delete-trash.sh -O /usr/local/bin/delete-trash
sudo chmod a+rx /usr/local/bin/delete-trash
sudo wget -nc https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/gnome/upgcln.sh -O /usr/local/bin/upgcln
sudo chmod a+rx /usr/local/bin/upgcln
echo "   "

echo "${txtbld} ${txtgrn} Adding Some Extra Eye Candy ${txtrst}"
mkdir ~/Public/temp/Wallpapers
mkdir ~/Public/temp/userpix
wget -nc https://www.dropbox.com/s/cusrakmofqlg4jw/Wallpapers.tar.gz -O ~/Public/temp/Wallpapers.tar.gz
wget -nc https://www.dropbox.com/s/cz8vm5b35zy6lns/userpix.tar.gz -O ~/Public/temp/userpix.tar.gz
sudo tar xzvf ~/Public/temp/Wallpapers.tar.gz -C /usr/share/xfce4/backdrops/
sudo tar xzvf ~/Public/temp/userpix.tar.gz -C /usr/share/pixmaps/
sudo ln /usr/share/icons/elementary-xfce/apps/32/gnome-do.png /usr/share/pixmaps/plank-config.png
cd
sleep 1s
echo " "

echo "${txtbld} ${txtgrn} Training Some Dragons ${txtrst}"
wget -nc https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/kde/useful-stuff.sh -O ~/Public/temp/useful-stuff.sh
wget -nc https://raw.githubusercontent.com/roo79x/my-script-n-stuff/master/xfce/xubuntu-postinstall-090517.sh -O ~/Public/temp/xubuntu-postinstall-090517.sh
cd /usr/share/applications
sudo mv exo-mail-reader.desktop exo-mail-reader.bak
sudo mv exo-web-browser.desktop exo-web-browser.bak
sudo mv libreoffice-math.desktop libreoffice-math.bak
sudo mv libreoffice-startcenter.desktop libreoffice-startcenter.bak
cd
echo "   "

echo "${txtbld} ${txtcyn} Update icon cache ${txtrst}"

sudo gtk-update-icon-cache /usr/share/icons/elementary-xfce-darkest/
#sudo gtk-update-icon-cache /usr/share/icons/Faba/
#sudo gtk-update-icon-cache /usr/share/icons/Moka-Cupertino/
#sudo gtk-update-icon-cache /usr/share/icons/XFFDT/
echo "     "

echo "${txtbld} ${txtgrn} Feeding the Sharks ${txtrst}"
cd
mv ~/Videos ~/Movies
sed -i 's/Videos/Movies/g' ~/.config/user-dirs.dirs
cp ~/.bashrc ~/.bashrc.old
sudo xdg-user-dirs-update
sleep 2s

echo "${txtbld} ${txtcyn} Doing a Final Update, Upgrade and 
Cleanup...[Cleanliness is next to Godliness you know!!] ${txtrst}"
sleep 2s
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade && sudo apt-get autoclean && sudo apt-get autoremove --purge

#Finished
echo "    "
echo "${txtbld} ${txtred} END OF LINE... ${txtrst}"
notify-send "Post Install Script Completed" "Xubuntu-Core Post Install Script Has Completed. END OF LINE..."
sleep 1s
echo "   "
