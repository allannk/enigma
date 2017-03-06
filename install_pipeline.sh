#!/bin/zsh

sudo chown $USER /srv -r
sudo chgrp $USER /srv -r

mkdir /srv/projects

git clone https://github.com/recoord/egon.git /srv/projects
ln -s /srv/projects/egon $HOME/egon