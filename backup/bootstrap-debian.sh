#!/bin/bash

list="git emacs xorg xinit build-essential tmux \
stumpwm exuberant-ctags global cmake libsqlite3-dev autoconf \
silversearcher-ag xcursor-themes
"

# apt-get update
sudo apt-get install -y $list


##############################
## vboxaddition
##############################

# sudo apt-get install linux-headers-$(uname -r)
# suod apt-get insatll dkms
# sudo mount /dev/src0 /media/cdrom
# cd /media/cdrom
# sudo ./VBoxLinuxAddition.sh

##############################
## clone configuration files
##############################

# git clone https://github.com/lihebi/dothebi ~/.hebi
# cd ~/.hebi/linux && ./install.sh
# cd ~/.hebi/tmux && ./install.sh
# cd ~/.hebi/bash && ./install.sh

## emacs
# git clone https://github.com/lihebi/emacs.d ~/.emacs.d
## install Source Code Pro


##############################
## Configuration
##############################

# update-alternative --config x-terminal-emulator



##############################
## 3rd party library
##############################

# find google chrome here: https://wiki.debian.org/UnofficialRepositories


##############################
## Helium
##############################

helium_list="gnulib libboost-all-dev"

# apt-get update
sudo apt-get install -y $helium_list
