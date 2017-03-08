#!/bin/zsh

# ----------------------------
# Install/Remove Base Packages
# ----------------------------
sudo pacman --noconfirm --needed -S cmake wget bash-completion
sudo pacman --noconfirm --needed -S nvidia nvidia-utils nvidia-libgl opencl-nvidia libglvnd
sudo pacman --noconfirm --needed -S gcc5 hardening-wrapper boost yasm glew
sudo pacman --noconfirm --needed -S python python-numpy netbeans qt4 atom nfs-utils gimp evince vlc
sudo pacman --noconfirm --needed -S eigen cuda ladspa libfdk-aac glfw-x11 glm enca libcaca networkmanager libdc1394
sudo pacman --noconfirm -R qt5-webengine akonadi-contacts akonadi-calendar calendarsupport akonadiconsole akonadi-calendar-tools eventviews incidenceeditor korganizer libkdepim kdepim-addons kdepim-runtime kgpg knotes kmail kalarm kaddressbook mailimporter pimcommon pim-data-exporter kdepim-apps-libs mailcommon pim-storage-service-manager mbox-importer messagelib libgravatar libksieve kontact pim-sieve-editor blogilo akonadi-import-wizard kmail-account-wizard grantlee-editor akregator



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
	echo -e "192.168.0.6:/mnt/video /mnt/video nfs rw,rsize=8192,wsize=8192,timeo=14,_netdev,auto" | sudo tee -a /etc/fstab >/dev/null
	echo -e "192.168.0.6:/mnt/data /mnt/data nfs rw,rsize=8192,wsize=8192,timeo=14,_netdev,auto" | sudo tee -a /etc/fstab >/dev/null	
fi
echo -e "Remounting all drives in /etc/fstab ..."
sudo mount -a


# ----------------------------
# Install precompiled Packages
# ----------------------------
sudo pacman --noconfirm --needed -U yaourt-1.8.1-1-any.pkg.tar.xz package-query-1.8-2-x86_64.pkg.tar.xz
sudo pacman --noconfirm --needed -U ffmpeg-git-3.3.r83754.gef86488696-1-x86_64.pkg.tar.xz

# ----------------------------
#  Install Homebrewn Packages
# ----------------------------

sudo pacman --noconfirm --needed -U sciter-sdk-git-r131.976f452-1-any.pkg.tar.xz
sudo pacman --noconfirm --needed -U opencv-3.2.0-1-any.pkg.tar.xz
sudo pacman --noconfirm --needed -U tensorflow-FAKE-r0.12-1-any.pkg.tar.xz


# ----------------------------
#    Install AUR Packages
# ----------------------------

# Might convert these to binary packages for speed/ease
yaourt --noconfirm --needed -S gitkraken cudnn rapidxml rapidjson-git

# Install bazel and post-remove protobuf (makedepend)
yaourt --m-arg "--skippgpcheck" --noconfirm --needed -S bazel
sudo pacman --noconfirm -R protobuf

# ----------------------------
#    Clone Pipeline to Disk
# ----------------------------
if [ ! -d /srv/projects/egon ]; then
	git clone https://github.com/recoord/egon.git /srv/projects/egon
	ln -s /srv/projects/egon $HOME/egon
fi

