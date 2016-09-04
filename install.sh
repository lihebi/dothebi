#!/bin/bash


# linux
ln -sf $HOME/.hebi/xinitrc $HOME/.xinitrc
ln -sf $HOME/.hebi/Xresources $HOME/.Xresources
ln -sf $HOME/.hebi/stumpwmrc $HOME/.stumpwmrc
ln -sf $HOME/.hebi/Xmodmap $HOME/.Xmodmap
ln -sf $HOME/.hebi/ratpoisonrc $HOME/.ratpoisonrc
ln -sf $HOME/.hebi/conkyrc $HOME/.conkyrc
ln -sf $HOME/.hebi/conkerorrc $HOME/.conkerorrc

# for xdm
ln -sf $HOME/.xinitrc $HOME/.xsession

# app
ln -sf $HOME/.hebi/stumpwm.d $HOME/.stumpwm.d

ln -sf $HOME/.hebi/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.hebi/xpdfrc $HOME/.xpdfrc

# bash
ln -sf $HOME/.hebi/bashrc $HOME/.bashrc
ln -sf $HOME/.hebi/bash_profile $HOME/.bash_profile
ln -sf $HOME/.hebi/bash_prompt $HOME/.bash_prompt


# symbol link
if [ -L $HOME/.fonts ]; then
    rm -f $HOME/.fonts
fi
ln -sf $HOME/.hebi/fonts $HOME/.fonts

# ln -sf $HOME/.hebi/offlineimaprc $HOME/.offlineimaprc
