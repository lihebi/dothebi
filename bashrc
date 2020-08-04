#!/bin/bash

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


PS1="\[\e[34m\]\w \[\e[31m\]>\[\e[33m\]>\[\e[32m\]> \[\e[39m\]$ "
# PS1='\u@\h \w $ '

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]; then
    PS1="[env] $PS1"
fi
if [ -n "$DOCKER_ENVIRONMENT" ]; then
    PS1="[docker] $PS1"
fi

if [ -n "$SSH_CLIENT" ]; then
    PS1="[ssh] $PS1"
fi

if [ `uname` == 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls -p --color=auto'
fi

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
export EDITOR="emacs -nw -q"
set -o ignoreeof


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

function docker-stop-all {
    sudo docker stop $(sudo docker ps -a -q)
}

function docker-remove-all {
    sudo docker rm $(sudo docker ps -a -q)
}
