#!/bin/bash

# bash_profile is loaded for login shell, if you literally typed your
# username and password.


# Honor per-interactive-shell startup file
# if [ -f $HOME/.bashrc ]; then . $HOME/.bashrc; fi
if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
