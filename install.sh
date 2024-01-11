#! /bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

user=$(id -u -n 1000)

apt update
apt upgrade -y

apt install nala

nala install build-essential libgtk2.0-dev libgtk-3-dev flatpak qemu virt-manager google-chrome-stable darktable kdenlive proxychains4 tor htop vim neofetch dolphin unzip libmysqlcppconn-dev obs-studio libavcodec-extra vlc -y

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.brave.Browser
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.mozilla.firefox
flatpak install flathub com.valvesoftware.Steam

wget -qO- https://packages.minecrosoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/packages.microsoft.gpg
sh -c 'ehco "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install code

echo "Add Developement Directories? (y/N)"
read devDirs

if [ $devDirs ]; then
	mkdir -p /home/$user/Dev/C++
	mkdir -p /home/$user/Dev/Java
	mkdir -p /home/$user/Dev/Python
	mkdir -p /home/$user/Dev/Assembly
	mkdir -p /home/$user/Dev/Scripts
	mkdir -p /home/$user/src-builds
	mkdir -p /home/$user/libs
	mkdir -p /home/$user/bin
fi

echo "Add GPU Switch for hybrid modes? (y/N)"
read isGPU

if [ $isGPU ]; then
	cp ./switchGPU.sh /home/$user/bin/switchGPU
	chmod +x /home/$user/bin/switchGPU
fi

exit

