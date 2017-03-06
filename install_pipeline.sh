#!/bin/zsh

sudo chown /srv $USER -R
sudo chgrp /srv $USER -R

mkdir /srv/projects

git clone https://github.com/recoord/egon.git /srv/projects
ln -s /srv/projects/egon $HOME/egon