#!/bin/bash

##############################
## .xinitrc file
##############################


# Load ~/.Xresources
# To see current loaded resources
# xrdb -query -all

# NEVER put xrdb into background,
# otherwise programs launched after xrdb may look for resouces before they are loaded

if [ -e $HOME/.Xresources ]; then
    xrdb -merge $HOME/.Xresources
fi

if [ -e $HOME/.hebi/local/Xresources ]; then
    xrdb -merge $HOME/.hebi/local/Xresources
fi

# merge PRIMARY and CLIPBOARD xsel
# if [ `which autocutsel` ]; then
#     autocutsel &
#     autocutsel -s PRIMARY &
# fi    


##############################
## Virtual Box Setting
##############################

# start clipboard sharing

if [ `which VBoxClient` ]; then
    VBoxClient --clipboard
fi


##############################
## Applications
##############################

export INFOPATH=$HOME/.info:$INFOPATH
# emacs --daemon &

if [ -e ~/.fehbg ]; then
   sh ~/.fehbg &
fi

xmodmap ~/.Xmodmap

##############################
## Window Manager
##############################

# put the xrandr setup in it
if [ -e $HOME/.hebi/local/xinitrc ]; then
    . $HOME/.hebi/local/xinitrc
fi

# exec stumpwm
# exec openbox
# exec ratpoison
exec sbcl --quit --load $HOME/.hebi/startstump
