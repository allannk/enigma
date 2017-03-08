#!/bin/sh

# Basic System Packages
sudo pacman --noconfirm --needed -S cmake git wget bash-completion python python2 python-numpy python2-numpy nfs-utils

# Install GFX Drivers
#sudo pacman --noconfirm --needed -U https://archive.archlinux.org/packages/n/nvidia/nvidia-375.26-6-x86_64.pkg.tar.xz https://archive.archlinux.org/packages/n/nvidia-utils/nvidia-utils-375.26-4-x86_64.pkg.tar.xz https://archive.archlinux.org/packages/n/nvidia-libgl/nvidia-libgl-375.26-3-x86_64.pkg.tar.xz https://archive.archlinux.org/packages/o/opencl-nvidia/opencl-nvidia-375.26-4-x86_64.pkg.tar.xz https://archive.archlinux.org/packages/l/libxnvctrl/libxnvctrl-375.26-1-x86_64.pkg.tar.xz
sudo pacman --noconfirm --needed -S nvidia nvidia-utils nvidia-libgl opencl-nvidia libxnvctrl