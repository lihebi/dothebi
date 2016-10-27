#!/bin/bash


# linux
ln -sf $HOME/.hebi/xinitrc $HOME/.xinitrc
ln -sf $HOME/.hebi/Xresources $HOME/.Xresources
ln -sf $HOME/.hebi/Xmodmap $HOME/.Xmodmap
ln -sf $HOME/.hebi/ratpoisonrc $HOME/.ratpoisonrc
ln -sf $HOME/.hebi/conkyrc $HOME/.conkyrc
ln -sf $HOME/.hebi/conkerorrc $HOME/.conkerorrc

# for xdm
ln -sf $HOME/.xinitrc $HOME/.xsession

# app

ln -sf $HOME/.hebi/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.hebi/xpdfrc $HOME/.xpdfrc
ln -sf $HOME/.hebi/sbclrc $HOME/.sbclrc

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

# desktop
# after this issue
# xdg-mime default emacsclient.desktop application/pdf
if [ ! -d $HOME/.local/share ]; then
    mkdir -p $HOME/.local/share
fi
rm -rf ~/.local/share/applications
ln -sf $HOME/.hebi/desktop $HOME/.local/share/applications

rm -rf $HOME/texmf
ln -sf $HOME/.hebi/texmf $HOME/texmf

ln -sf $HOME/.hebi/newsrc $HOME/.newsrc
