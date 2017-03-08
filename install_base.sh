#!/bin/bash

# Pacman Packages
pkg_base=(cmake bash-completion)
pkg_libs=(gcc5 hardening-wrapper boost eigen)
pkg_deps=(yasm glew ladspa libfdk-aac glfw-x11 glm enca libcaca libdc1394)
pkg_util=(python python-numpy python2 python2-numpy screen)
pkg_apps=(netbeans atom vlc gimp audacity evince)
pkg_graphics=(nvidia nvidia-utils nvidia-libgl nvidia-settings opencl-nvidia libglvnd cuda)
pacman_packages=(${pkg_base[@]} ${pkg_libs[@]} ${pkg_deps[@]} ${pkg_util[@]} ${pkg_apps[@]})

#${pkg_graphics[@]}

# Custom Packages
custom_packages=yaourt-1.8.1-1-any.pkg.tar.xz package-query-1.8-2-x86_64.pkg.tar.xz
custom_packages+=ffmpeg-git-3.3.r83754.gef86488696-1-x86_64.pkg.tar.xz
custom_packages+=sciter-sdk-git-r131.976f452-1-any.pkg.tar.xz
custom_packages+=opencv-3.2.0-1-any.pkg.tar.xz
custom_packages+=tensorflow-FAKE-r0.12-1-any.pkg.tar.xz
custom_packages+=rapidxml-1.13-1-any.pkg.tar.xz

# AUR Packages
aur_packages=(gitkraken cudnn rapidjson-git)


# Install all packages
sudo pacman --noconfirm --needed -S ${pacman_packages[@]}



#sudo pacman --noconfirm --needed -U ${custom_packages[@]}
#yaourt --noconfirm --needed -S ${aur_packages[@]}




# sudo pacman --noconfirm -R qt5-webengine akonadi-contacts akonadi-calendar calendarsupport akonadiconsole akonadi-calendar-tools eventviews incidenceeditor korganizer libkdepim kdepim-addons kdepim-runtime kgpg knotes kmail kalarm kaddressbook mailimporter pimcommon pim-data-exporter kdepim-apps-libs mailcommon pim-storage-service-manager mbox-importer messagelib libgravatar libksieve kontact pim-sieve-editor blogilo akonadi-import-wizard kmail-account-wizard grantlee-editor akregator







# # Might convert these to binary packages for speed/ease
# yaourt --noconfirm --needed -S gitkraken cudnn rapidxml rapidjson-git

# # Install bazel and post-remove protobuf (makedepend)
# yaourt --m-arg "--skippgpcheck" --noconfirm --needed -S bazel
# sudo pacman --noconfirm -R protobuf

# ----------------------------
#    Clone Pipeline to Disk
# ----------------------------
if [ ! -d /srv/egon ]; then
	git clone https://github.com/recoord/egon.git /srv/egon
	ln -s /srv/egon $HOME/egon
fi

