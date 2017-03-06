#!/bin/zsh

sudo chown $USER /srv -R
sudo chgrp $USER /srv -R

mkdir /srv/projects

git clone https://github.com/recoord/egon.git /srv/projects/egon
ln -s /srv/projects/egon $HOME/egon