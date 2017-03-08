#!/bin/sh

# ----------------------------
#     Manipulate Folders
# ----------------------------

# Own folders we will be using!
sudo chown $USER /srv -R
sudo chmod a+rwx /tmp 

# Create projects folder and mount folders
mkdir -p /srv/projects
sudo mkdir -p /mnt/hdd
sudo mkdir -p /mnt/usb

# Mount HDD and NFS drive
sudo mkdir -p /mnt/data
sudo mkdir -p /mnt/video
if grep -e "192.168.0.6" /etc/fstab >/dev/null; then
	echo -e "Dendron Mount Point already specified in /etc/fstab. If broken, remove these lines first!\n"
	exit 1
else
	echo -e "Adding dendron NFS to '/etc/fstab' for automounting on boot ...\n"
	echo -e "# Mount Dendron NFS" | sudo tee -a /etc/fstab >/dev/null
	echo -e "192.168.0.6:/mnt/video /mnt/video nfs rw,rsize=8192,wsize=8192,timeo=14,_netdev,auto,nofail" | sudo tee -a /etc/fstab >/dev/null
	echo -e "192.168.0.6:/mnt/data /mnt/data nfs rw,rsize=8192,wsize=8192,timeo=14,_netdev,auto,nofail" | sudo tee -a /etc/fstab >/dev/null	
fi
echo -e "Remounting all drives in /etc/fstab ..."
sudo mount -a


# Basic System Packages
sudo pacman --noconfirm --needed -S cmake git wget bash-completion python python2 python-numpy python2-numpy nfs-utils

# Clone Enigma to /srv
git clone https://github.com/allannk/enigma.git /srv

# Install GFX Drivers
#sudo pacman --noconfirm --needed -U 
# https://archive.archlinux.org/packages/n/nvidia/nvidia-375.26-6-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/n/nvidia-utils/nvidia-utils-375.26-4-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/n/nvidia-libgl/nvidia-libgl-375.26-3-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/o/opencl-nvidia/opencl-nvidia-375.26-4-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/l/libxnvctrl/libxnvctrl-375.26-1-x86_64.pkg.tar.xz

# sudo pacman --noconfirm --needed -S nvidia nvidia-utils nvidia-libgl opencl-nvidia libxnvctrl