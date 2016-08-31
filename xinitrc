#!/bin/bash


##############################
## .xinitrc file
##############################


# Load ~/.Xresources
# To see current loaded resources
# xrdb -query -all

# NEVER put xrdb into background,
# otherwise programs launched after xrdb may look for resouces before they are loaded

if [ -e ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi


# dynamically adjust DPI setting
# dpi=$(xdpyinfo | grep resolution | awk '{print $2}')
# dpi=${dpi%x*}
# if [ -n $dpi ]; then
#     dpi="$dpi*2"
#     # dpi=$((dpi)) # not working, need to use bc
#     dpi=$(echo $dpi | bc)
#     echo "Xft.dpi: $dpi" | xrdb -merge
# fi

xres=$(xdpyinfo | grep dimension | awk '{print $2}' | awk -F 'x' '{print $1}')
yres=$(xdpyinfo | grep dimension | awk '{print $2}' | awk -F 'x' '{print $2}')
if [ -n $yres ]; then
    yres_num=$(echo $yres | bc)
    xres_num=$(echo $xres | bc)
    if [ $yres_num -eq 1600 ]; then
        # macbook
        echo "Xft.dpi: 144" | xrdb -merge;
    elif [ $xres_num -eq 2560 ]; then
        # 29UM67-P
        echo "Xft.dpi: 128" | xrdb -merge;
    else
        echo "Xft.dpi: 96" | xrdb -merge;
    fi
        
    # if [[ $yres == "1080" ]]; then
    #     # 1080p
    #     echo "Xft.dpi: 96" | xrdb -merge;
    # elif [[ $yres == "1600" ]]; then
    #     # macbook
    #     echo "Xft.dpi: 144" | xrdb -merge;
    # else
    #     # other
    #     echo "Xft.dpi: 96" | xrdb -merge;
    # fi
fi

# merge PRIMARY and CLIPBOARD xsel
if [ `which autocutsel` ]; then
    autocutsel &
    autocutsel -s PRIMARY &
fi    


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

emacs --daemon &

# if [ -e ~/.fehbg ]; then
#    sh ~/.fehbg &
# fi

xmodmap ~/.Xmodmap

##############################
## Window Manager
##############################

exec stumpwm
# exec openbox
# exec ratpoison
