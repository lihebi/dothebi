#!/bin/bash

export EMAIL="lihebi.com@gmail.com"
export NAME="Hebi Li"
export SMTPSERVER="smtp.gmail.com"

# bashrc is loaded for non-login shell. When you have already loged in
# a system, and open a new terminal window.

##############################
## This is the prologue from GuixSD .bashrc

# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

# if [[ $- != *i* ]]
# then
#     # We are being invoked from a non-interactive shell.  If this
#     # is an SSH session (as in "ssh host command"), source
#     # /etc/profile so we get PATH and other essential variables.
#     [[ -n "$SSH_CLIENT" ]] && source /etc/profile

#     # Don't do anything else.
#     return
# fi

# Source the system-wide file.
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi
alias ls='ls -p --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias grep='grep --color=auto'

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

##############################
## Common Config
##############################

# setting the TERM should not be a good idea
# tmux gives me screen-256color
# and I found it works great with:
# - emacs solarized color
# - terminal solarized color
# - inside docker
# when setting all these 3, emacs inside docker is great
# actaully on my machine, it sets to screen-256color when using tmux
# and set to rxvt-unicode-256color when using urxvt only
# but I cannot set the color to rxvt-unitcode-256color inside docker
export TERM=screen-256color
# export TERM=xterm-256color
export EDITOR="emacsclient -t"
set -o ignoreeof

##############################
## PATH
##############################

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin"

# Helium
export ASAN_OPTIONS=detect_leaks=0:detect_stack_use_after_scope=0

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH=$HOME/bin:$PATH
# export INFOPATH=$HOME/.info:$INFOPATH


##############################
## Alias
##############################


alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias gs="git status"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gm='git commit -m'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# alias myqemu="qemu-system-x86_64 -net user -net nic,model=virtio -vga virtio -enable-kvm -m 2048 -cpu host -smp 8"
alias myqemu="qemu-system-x86_64 -vga virtio -enable-kvm -m 8196 -cpu host -smp 2"
# win10 network:
# qemu-system-x86_64 -enable-kvm -m 4096 -vga virtio -soundhw hda -cpu host -smp 8 win10.img

export GUIX_PACKAGE_PATH="$HOME/github/guix-channel/"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

# This is important: the emacs and elisp info files appear only here
# export INFOPATH="$HOME/.guix-profile/share/info${INFOPATH:+:}$INFOPATH"

# The default profile of current profile
GUIX_PROFILE="$HOME/.guix-profile"
source "$HOME/.guix-profile/etc/profile"
# The above profile set XDG_DATA_DIRS. However, in case of using arch
# and guix together, I install gnome using pacman, and I must set this
# back, otherwise, gnome does not start, and browser cannot open
# upload dialog.
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$XDG_DATA_DIRS"
source "$HOME/.config/guix/current/etc/profile"

# This is the current guix binary resulted from guix pull. Keep this
# at the front of the list
export PATH="$HOME/.config/guix/current/bin:$PATH"
export INFOPATH="$HOME/.config/guix/current/share/info:$INFOPATH"


# pip install --user xxx: will install under this folder
# python3 -m site --user-base: show the local folder
export PATH="/home/hebi/.local/bin/:$PATH"

# Using this will make commands such as ls, python3 segment fault
# export LD_LIBRARY_PATH="/home/hebi/.guix-profile/lib"
#
# HACK I have to hack to use the gcc-...-lib/lib/libstdc++.so.6 so
# that python from scipy import sparse (and some others like jupyter
# notebook) will work


# CUDA ubuntu
# /usr/local/cuda-9.2/doc has many pdf documents
CUDA_PATH=/usr/local/cuda-10.0
# CUDA_PATH=/usr/local/cuda-9.0
export LD_LIBRARY_PATH="$CUDA_PATH/lib64:$LD_LIBRARY_PATH"
export PATH="$CUDA_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_PATH/extras/CUPTI/lib64"
# cudnn
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"


# Java classpath
export CLASSPATH=/home/hebi/bin/stanford-corenlp-3.9.2.jar:$CLASSPATH
# export CLASSPATH=/home/hebi/github/cs587/rmi:$CLASSPATH

# Python path
export PYTHONPATH="/home/hebi/github/reading/cleverhans/:$PYTHONPATH"


# other deep learning model related paths
# transformer example
export PARAM_SET=base
export DATA_DIR=$HOME/transformer/data
export MODEL_DIR=$HOME/transformer/model_$PARAM_SET
export VOCAB_FILE=$DATA_DIR/vocab.ende.32768
