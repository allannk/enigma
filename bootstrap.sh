#!/bin/bash

# Basic System Packages
echo -e "Installing basic tools >> \e[32mgit nfs-utils\e[39m"
sudo pacman --noconfirm --needed -S git nfs-utils >/dev/null

if (pacman -Q nfs-utils >/dev/null && pacman -Q git >/dev/null)

# Own folders we will be using!
echo -e "Claiming folders >> \e[32m/srv /tmp\e[39m"
sudo chown $USER /srv -R
sudo chmod a+rwx /tmp

# Create projects folder and mount folders
echo -e "Creating mountpoints >> \e[32m /mnt/ [hdd,usb,data,video]\e[39m"
sudo mkdir -p /mnt/hdd /mnt/usb /mnt/data /mnt/video

# Mount HDD and NFS drive
echo -e "Installing automount >> \e[32m /mnt/ [data,video]\e[39m"
if grep -e "192.168.0.6" /etc/fstab >/dev/null; then
	echo -e "  > Dendron Mount Point already specified in /etc/fstab. If broken, remove these lines first!\n"
else
	echo -e "Adding dendron NFS to '/etc/fstab' for automounting on boot ...\n"
	echo -e "# Mount Dendron NFS" | sudo tee -a /etc/fstab >/dev/null
	echo -e "192.168.0.6:/mnt/video /mnt/video nfs rw,rsize=8192,wsize=8192,timeo=14,_netdev,auto,nofail" | sudo tee -a /etc/fstab >/dev/null
	echo -e "192.168.0.6:/mnt/data /mnt/data nfs rw,rsize=8192,wsize=8192,timeo=14,_netdev,auto,nofail" | sudo tee -a /etc/fstab >/dev/null	
	echo -e "Remounting all drives in /etc/fstab ..."
	sudo mount -a
fi

# Clone Enigma to /srv
if [ ! -d /srv/enigma ]; then
	echo -e "Cloning \e[32mEnigma\e[39m to \e[32m/srv\e[39m for future maintainance"
	git clone https://github.com/allannk/enigma.git /srv/enigma
	echo -e "Bootstrapping done. Continue installation by running 'sh /srv/enigma/system_install.sh'"
fi

# Pacman Packages
pkg_base=(cmake bash-completion)
pkg_adm=(dmidecode openssh)
pkg_deps=(yasm glew ladspa libfdk-aac glfw-x11 glm enca libcaca libdc1394 rapidjson)
pkg_util=(gcc5 hardening-wrapper boost boost-libs eigen python python-numpy python2 python2-numpy screen)
pkg_apps=(netbeans vlc gimp audacity evince konsole)
pkg_graphics=(cuda nvidia nvidia-utils nvidia-libgl nvidia-settings opencl-nvidia libglvnd mesa xf86-video-intel)
pkg_desktop=(xorg-server xorg-xinit xorg-xrandr plasma-desktop sddm)
pacman_packages=(${pkg_base[@]} ${pkg_adm[@]} ${pkg_deps[@]} ${pkg_util[@]} ${pkg_apps[@]} ${pkg_graphics[@]} ${pkg_desktop[@]})
sudo pacman --noconfirm --needed -S ${pacman_packages[@]}

# Custom Packages
sudo pacman --noconfirm --needed -U /usr/enigma/package-query-1.8-2-x86_64.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/yaourt-1.8.1-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/ffmpeg-git-3.3.r83754.gef86488696-1-x86_64.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/sciter-sdk-git-r131.976f452-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/opencv-3.2.0-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/tensorflow-r0.12-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/rapidxml-1.13-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/gitkraken-2.1.0-3-x86_64.pkg.tar.xz 
sudo pacman --noconfirm --needed -U /usr/enigma/protobuf-11.0.0-1-any.pkg.tar.xz

# AUR Packages
aur_packages=(cudnn)
yaourt --noconfirm --needed -S ${aur_packages[@]}

# Update Boot Settings
sudo mkinitcpio -p linux

# Apply patches to the system
system=`sudo dmidecode | grep Product`
if [[ $system =~ .*Z170I.* ]]; then
	patches/Z170I.sh
elif [[ $system =~ .*GS43VR.* ]]; then
	patches/GS43VR.sh
fi




# sudo pacman --noconfirm -R qt5-webengine akonadi-contacts akonadi-calendar calendarsupport akonadiconsole akonadi-calendar-tools eventviews incidenceeditor korganizer libkdepim kdepim-addons kdepim-runtime kgpg knotes kmail kalarm kaddressbook mailimporter pimcommon pim-data-exporter kdepim-apps-libs mailcommon pim-storage-service-manager mbox-importer messagelib libgravatar libksieve kontact pim-sieve-editor blogilo akonadi-import-wizard kmail-account-wizard grantlee-editor akregator





# # Install bazel and post-remove protobuf (makedepend)
# yaourt --m-arg "--skippgpcheck" --noconfirm --needed -S bazel
# sudo pacman --noconfirm -R protobuf

# ----------------------------
#    Clone Pipeline to Disk
# ----------------------------
# if [ ! -d /srv/egon ]; then
# 	git clone https://github.com/recoord/egon.git /srv/egon
# 	ln -s /srv/egon $HOME/egon
# fi

