#!/bin/zsh

# Own folders we will be using!
sudo chown $USER /srv -R
sudo chmod a+rwx /tmp 

# Create projects folder and mount folders
mkdir -p /srv/projects
sudo mkdir -p /mnt/hdd 
sudo mkdir -p /mnt/usb

# Install basic packages
sudo pacman --noconfirm --needed -S cmake gcc5 bash-completion eigen cuda yasm ladspa hardening-wrapper libfdk-aac nvidia-utils opencl-nvidia libglvnd boost glfw-x11 glm enca libcaca python python-numpy gimp evince vlc networkmanager qt4

# Install yaourt if not present
# TODO

# Install ffmpeg-git
sudo pacman --noconfirm -U ffmpeg-git-3.3.r83754.gef86488696-1-x86_64.pkg.tar.xz
# Alternative: pacman -S ffmpeg-git

# Install bazel and post-remove protobuf (makedepend)
yaourt --m-arg "--skippgpcheck" --noconfirm --needed -S bazel
sudo pacman --noconfirm -R protobuf

# Install cuDNN
yaourt -S cudnn

# Compile & Install OpenCV
#install_opencv

# Compile and Install TensorFlow
#install_tensorflow