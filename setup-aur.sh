#!/bin/bash

# AUR
if [ -d $HOME/tmp ]; then
    rm -rf $HOME/tmp
fi
mkdir -p $HOME/tmp
cd $HOME/tmp

git clone https://aur.archlinux.org/quicklisp
cd quicklisp && makepkg --noconfirm --needed -si && cd -

git clone https://aur.archlinux.org/translate-shell
cd translate-shell && makepkg --noconfirm --needed -si && cd -

git clone https://aur.archlinux.org/global
cd global && makepkg --noconfirm --needed -si && cd -

# conflicing with acpilight cannot be resolved
git clone https://aur.archlinux.org/acpilight
echo "TODO Make acpilight manually"
# cd acpilight && makepkg --noconfirm --needed -si && cd -


# git clone https://aur.archlinux.org/clx-git
# git clone https://aur.archlinux.org/cl-alexandria
# git clone https://aur.archlinux.org/stumpwm-git
# cd cl-ppcre && makepkg -si
# cd clx-git && makepkg -si
# cd cl-alexandria && makepkg -si
# cd stumpwm-git && makepkg -si
