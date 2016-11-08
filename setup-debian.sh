#!/bin/bash


# before running this script, you should already installed
# - emacs, git, sudo
# - added your user to sudo group
# - change the package source to testing, and dist upgrade the system

# clone .hebi .emacs.d .stumpwm.d .info
# [ -d .hebi ] || git clone https://github.com/lihebi/dothebi .hebi
# [ -d .emacs.d ] || git clone https://github.com/lihebi/emacs.d .emacs.d
# [ -d .stumpwm.d ] || git clone https://github.com/lihebi/stumpwm.d .stumpwm.d
# [ -d .info ] || git clone https://github.com/lihebi/info .info

packages=$(cat debian-packages.conf  | sed 's/#.*//g' | sed '/^$/d')
packages+=" linux-headers-$(uname -r)"
echo "Installing package: "
echo $packages
sudo apt-get -y install packages

# update-alternative for x-www-browser and x-terminal-emulator
# update-alternative --config x-terminal-emulator
# update-alternative --config x-www-browser

# some git config

# git config --global user.name "Hebi Li"
# git config --global user.email "lihebi.com@gmail.com"
# git config --global credential.helper cache
# git config --global push.default simple


# after this script, you need to do the following additional steps
# - compile and install gtest from source
# - download srcml
# - install quicklisp
# - install translate-shell

