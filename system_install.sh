#!/bin/bash

# Pacman Packages
pkg_base=(cmake bash-completion)
pkg_adm=(dmidecode)
pkg_deps=(yasm glew ladspa libfdk-aac glfw-x11 glm enca libcaca libdc1394)
pkg_util=(gcc5 hardening-wrapper boost boost-libs eigen python python-numpy python2 python2-numpy screen)
pkg_apps=(netbeans vlc gimp audacity evince)
pkg_graphics=(cuda nvidia nvidia-utils nvidia-libgl nvidia-settings opencl-nvidia libglvnd mesa xf86-video-intel)
pkg_desktop=(xorg-server xorg-xinit xorg-xrandr plasma-desktop sddm)
pacman_packages=(${pkg_base[@]} ${pkg_adm[@]} ${pkg_deps[@]} ${pkg_util[@]} ${pkg_apps[@]} ${pkg_graphics[@]} ${pkg_desktop[@]})
sudo pacman --noconfirm --needed -S ${pacman_packages[@]}

# Custom Packages
sudo pacman --noconfirm --needed -U package-query-1.8-2-x86_64.pkg.tar.xz 
sudo pacman --noconfirm --needed -U yaourt-1.8.1-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U ffmpeg-git-3.3.r83754.gef86488696-1-x86_64.pkg.tar.xz 
sudo pacman --noconfirm --needed -U sciter-sdk-git-r131.976f452-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U opencv-3.2.0-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U tensorflow-r0.12-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U rapidxml-1.13-1-any.pkg.tar.xz 
sudo pacman --noconfirm --needed -U gitkraken-2.1.0-3-x86_64.pkg.tar.xz 

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

