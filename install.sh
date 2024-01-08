#! /bin/bash

user=$(id -u -n )

apt update
apt upgrade -y

apt install git build-essential libgtk2.0-dev libgtk-3-dev flatpak gnome-software gnome-software-plugin-flatpak git qemu google-chrome-stable software-properties-common apt-transport-https gpg wget darktable kdenlive proxychains4 tor htop vim neofetch dolphin unzip -y

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

mkdir -p /home/$user/Dev/C++
mkdir -p /home/$user/Dev/Java
mkdir -p /home/$user/Dev/Python
mkdir -p /home/$user/Dev/Assembly
mkdir -p /home/$user/Dev/Scripts
mkdir -p /home/$user/src-builds
mkdir -p /home/$user/libs
mkdir -p /home/$user/bin

cp ./switchGPU.sh /home/$user/bin/switchGPU
chmod +x /home/$user/bin/switchGPU

