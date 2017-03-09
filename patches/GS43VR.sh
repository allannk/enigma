#!/bin/bash

# 1. Patch ~/.xinitrc to disable Intel GPU
# 2. Patch XORG to disable Intel GPU and only use NVIDIA GPU
# 3. Patch 

cat >~/.xinitrc <<EOL
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
exec startkde
EOL

cat >/etc/X11/xorg.conf <<EOL
Section "ServerLayout"
  Identifier "layout"
  Screen 0 "nvidia"
  Inactive "intel"
EndSection

Section "Device"
  Identifier "nvidia"
  Driver     "nvidia"
  BusID      "PCI:1:00:00"
EndSection

Section "Screen"
  Identifier "nvidia"
  Device "nvidia"
  Option "AllowEmptyInitialConfiguration"
EndSection

Section "Device"
  Identifier "intel"
  Driver     "modesetting"
EndSection

Section "Screen"
  Identifier "intel"
  Device     "intel"
EndSection
EOL

cat >/etc/X11/xorg.conf <<EOL

EOL