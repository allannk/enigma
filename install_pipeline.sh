#!/bin/zsh

sudo chown /srv $USER -r
sudo chgrp /srv $USER -r

mkdir /srv/projects

git clone https://github.com/recoord/egon.git /srv/projects
ln -s /srv/projects/egon $HOME/egon