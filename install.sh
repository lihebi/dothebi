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
ln -sf $HOME/.hebi/sbclrc $HOME/.sbclrc

# bash
ln -sf $HOME/.hebi/bashrc $HOME/.bashrc
ln -sf $HOME/.hebi/bash_profile $HOME/.bash_profile
ln -sf $HOME/.hebi/bash_prompt $HOME/.bash_prompt
ln -sf $HOME/.hebi/profile $HOME/.profile


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


rm -rf ~/texmf
mkdir -p ~/texmf/tex/latex/local
# FIXME this could only work in /usr/local/share/texmf folder
# than I need sudo mktexlsr to updat, then reboot system ...
# but at least it works now ...
# Setting the TEXMFHOME=/home/hebi/texmf and TEXMFDBS=/home/hebi/texmf does not help ...
if [ ! -d $HOME/texmf/tex/latex/local/fse ]; then
    mkdir -p $HOME/texmf/tex/latex/local/fse
fi
ln -sf $HOME/.hebi/latex $HOME/texmf/tex/latex/local/fse

ln -sf $HOME/.hebi/newsrc $HOME/.newsrc
