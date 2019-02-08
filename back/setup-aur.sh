#!/bin/bash

mkdir -p $HOME/tmp
cd $HOME/tmp

function install_aur {
    if [ -d $1 ]; then
        echo "$1 Exists"
    else
        git clone https://aur.archlinux.org/$1
        cd $1 && makepkg --noconfirm --needed -si && cd -
    fi
}

install_aur bear
install_aur quicklisp
install_aur translate-shell
install_aur global

# conflicing with acpilight cannot be resolved
# install_aur acpilight
# git clone https://aur.archlinux.org/acpilight
# echo "TODO Make acpilight manually"
