#!/bin/bash

# bash_profile is loaded for login shell, if you literally typed your
# username and password.

# . $HOME/.bashrc

# Honor per-interactive-shell startup file
if [ -f $HOME/.bashrc ]; then . $HOME/.bashrc; fi

# export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

# Somehow I have to have this, the source of bashrc does not work. No
# Idea why. It is not sourced?
source "$HOME/.guix-profile/etc/profile"
source "$HOME/.config/guix/current/etc/profile"
