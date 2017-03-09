#!/bin/bash

# Basic System Packages
echo -e "Installing basic tools >> \e[32mgit nfs-utils\e[39m"
sudo pacman --noconfirm --needed -S git nfs-utils >/dev/null

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
fi

# Install GFX Drivers
#sudo pacman --noconfirm --needed -U 
# https://archive.archlinux.org/packages/n/nvidia/nvidia-375.26-6-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/n/nvidia-utils/nvidia-utils-375.26-4-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/n/nvidia-libgl/nvidia-libgl-375.26-3-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/o/opencl-nvidia/opencl-nvidia-375.26-4-x86_64.pkg.tar.xz 
# https://archive.archlinux.org/packages/l/libxnvctrl/libxnvctrl-375.26-1-x86_64.pkg.tar.xz