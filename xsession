if [ -e $HOME/.Xresources ]; then
    xrdb -merge $HOME/.Xresources
fi
xmodmap ~/.Xmodmap


# exec stumpwm
# exec openbox
# exec ratpoison
# exec i3

exec sbcl --quit --load $HOME/.hebi/startstump

# make sure exwm is configured
# exec emacs
# exec dbus-launch --exit-with-session emacs
 
