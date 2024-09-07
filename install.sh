#! /bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

echo "which user is being set up? (uid) "
read userID

user=$(id -u -n $userID)

apt update
apt upgrade -y

# install essentials
apt install htop vim neofetch unzip curl wget gpg flatpak tmux kitty vlc

# install development
apt install build-essential libgtk2.0-dev libgtk-3-dev libmysqlcppconn-dev qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemone virt-manager libstdc++-12-dev

# install extra
apt install darktable kdenlive proxychains4 obs-studio

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.brave.Browser
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.mozilla.firefox

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > linux_signing_key.pub
install -D -o root -g root -m 644 linux_signing_key.pub /etc/apt/keyrings/linux_signing_key.pub
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/linux_signing_key.pub] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
apt update
apt install google-chrome-stable

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install code

curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update
apt install spotify-client

echo "Add Developement Directories? (True/false)"
read devDirs

if $devDirs; then
	mkdir -p /home/$user/Dev/C++
	mkdir -p /home/$user/Dev/Java
	mkdir -p /home/$user/Dev/Python
	mkdir -p /home/$user/Dev/Assembly
	mkdir -p /home/$user/Dev/Scripts
	mkdir -p /home/$user/Dev/SchoolProjects
	mkdir -p /home/$user/Dev/src-builds
	mkdir -p /home/$user/libs
	mkdir -p /home/$user/bin
fi

echo "Add GPU Switch for hybrid modes? (True/false)"
read isGPU

if $isGPU; then
	cp ./switchGPU.sh /home/$user/bin/switchGPU
	chmod +x /home/$user/bin/switchGPU
fi

rm linux_signing_key.pub
rm packages.microsoft.gpg

# Setup qemu
echo "Please verify that libvirtd is running, hit enter to continue if libvirtd is running"
read isLibvirt

if $isLibvert; then
	virsh net-start default
	virsh net-autostart default

	usermod -aG libvirt $user
	usermod -aG libvirt-qemu $user
	usermod -aG kvm $user
	usermod -aG input $user
	usermod -aG disk $USER
fi

exit

