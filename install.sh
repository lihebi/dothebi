#!/bin/bash


# linux
# ln -sf $HOME/.hebi/xinitrc $HOME/.xinitrc
ln -sf $HOME/.hebi/Xresources $HOME/.Xresources
ln -sf $HOME/.hebi/Xmodmap $HOME/.Xmodmap
ln -sf $HOME/.hebi/ratpoisonrc $HOME/.ratpoisonrc
ln -sf $HOME/.hebi/conkyrc $HOME/.conkyrc
ln -sf $HOME/.hebi/conkerorrc $HOME/.conkerorrc

if [ -d $HOME/.vnc ]; then
    rm -rf $HOME/.vnc
fi
ln -sf $HOME/.hebi/vnc $HOME/.vnc

# for xdm
ln -sf $HOME/.hebi/xsession $HOME/.xsession

# app

ln -sf $HOME/.hebi/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.hebi/xpdfrc $HOME/.xpdfrc
# ln -sf $HOME/.hebi/sbclrc $HOME/.sbclrc

# bash
ln -sf $HOME/.hebi/bashrc $HOME/.bashrc
ln -sf $HOME/.hebi/bash_profile $HOME/.bash_profile


# symbol link
if [ -L $HOME/.fonts ]; then
    rm -f $HOME/.fonts
fi
ln -sf $HOME/.hebi/fonts $HOME/.fonts

# ln -sf $HOME/.hebi/offlineimaprc $HOME/.offlineimaprc

# desktop
# after this issue
# xdg-mime default emacsclient.desktop application/pdf

# if [ ! -d $HOME/.local/share ]; then
#     mkdir -p $HOME/.local/share
# fi
# rm -rf ~/.local/share/applications
# ln -sf $HOME/.hebi/desktop $HOME/.local/share/applications

# rm -rf $HOME/texmf
# if [ $(uname) == 'Darwin' ]; then
#     ln -sf $HOME/.hebi/texmf $HOME/Library/
# else
#     ln -sf $HOME/.hebi/texmf $HOME/
# fi

ln -sf $HOME/.hebi/newsrc $HOME/.newsrc
ln -sf $HOME/.hebi/newsrc.eld $HOME/.newsrc.eld

ln -sf $HOME/.hebi/pylintrc $HOME/.pylintrc

if [ -d $HOME/.docker ]; then
    rm -rf $HOME/.docker
fi
ln -sf $HOME/.hebi/docker $HOME/.docker

# openbox
# if [ ! -d $HOME/.config ]; then
#     mkdir -p $HOME/.config
# fi
# if [ -d $HOME/.config/openbox ]; then
#     rm -rf $HOME/.config/openbox
# fi
# ln -sf $HOME/.hebi/openbox $HOME/.config/

# mpd
# if [ ! -d $HOME/.config/mpd ]; then
#     mkdir -p $HOME/.config/mpd
# fi

# ln -sf $HOME/.hebi/mpd.conf $HOME/.config/mpd/
# rm -rf $HOME/.mpd
# ln -sf $HOME/.hebi/mpd $HOME/.mpd
