#!/bin/bash

##############################
## This is the prologue from GuixSD .bashrc

# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

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
alias ll='ls -l'
alias grep='grep --color=auto'

## End of GuixSD prologue
##############################


# alias ls="ls -F ${colorflag}"
# alias l="ls"
# alias ll="ls -l"
# alias la="ls -a"
# # list only directories
# alias lsd="ll | grep --color=never '^d'"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
export HELIUM_HOME=$HOME/github/helium
export PATH=$HELIUM_HOME/bin:$HELIUM_HOME/scripts:$PATH
export PATH=$HELIUM_HOME/scripts/analyze:$HELIUM_HOME/scripts/hexp:$PATH
export ASAN_OPTIONS=detect_leaks=0:detect_stack_use_after_scope=0

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PATH=$HOME/bin:$PATH
export INFOPATH=$HOME/.info:$INFOPATH


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

alias emacs="emacs -nw"         # no window system if invoke from command line
alias ec="emacsclient -t"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias helium-clang="clang -Xclang -load -Xclang /home/hebi/github/helium2/build/lib/libhelium.so"

##############################
## source other files
##############################

# file="$HOME/.bash_prompt"
# [ -r $file ] && [ -f $file ] && source $file
# unset file

# my own prompt
red="\e[1;31m";
yellow="\e[1;33m";
white="\e[1;37m";
bold='';
case "$TERM" in
    # this is for Emacs tramp (tramp-terminal-type)
"dumb")
    PS1="> "
    ;;
xterm*|rxvt*|eterm*|screen*)
    # PS1="my fancy multi-line \n prompt > "
    PS1=""
    # user
    if [[ "${USER}" == "root" ]]; then
        PS1+="\[${red}\]"
    else
        PS1+="\[${yellow}\]"
    fi
    PS1+="\u"
    PS1+="\[${white}\]"
    PS1+="@"
    # host
    if [[ "${SSH_TTY}" ]]; then
        PS1+="${bold}${red}";
    elif [[ "${DOCKER_TTY}" ]]; then
        PS1+="${bold}${red}DOCKER-"
    else
        PS1+="${yellow}";
    fi;
    PS1+="\h"
    PS1+="\[${white}\]"
    PS1+="&"
    PS1+="\[${green}\]\w"; # working directory
    # newline
    PS1+="\n";
    PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
    ;;
*)
    PS1="> "
    ;;
esac


# bash-completion

# if which brew > /dev/null 2>&1 && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
#     source "$(brew --prefix)/share/bash-completion/bash_completion";
# elif [ -f /etc/bash_completion ]; then
#     source /etc/bash_completion;
# fi;

# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
#     . /usr/share/bash-completion/bash_completion

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
# [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# if [[ -f $HOME/.hebi/local/bashrc ]]; then
#     . $HOME/.hebi/local/bashrc
# fi


## Remember to install them! Otherwise all the compilation is likely to fail!
# export CC=/usr/bin/clang
# export CXX=/usr/bin/clang++

# FIXME GuixSD name
if [[ `uname` == "GuixSD" ]]; then


    export PKG_CONFIG_PATH="/home/hebi/.guix-profile/lib/pkgconfig${PKG_CONFIG_PATH:+:}$PKG_CONFIG_PATH"
    export PKG_CONFIG_PATH="/home/hebi/.guix-profile/lib/pkgconfig:/home/hebi/.guix-profile/share/pkgconfig${PKG_CONFIG_PATH:+:}$PKG_CONFIG_PATH"
    export PATH="/home/hebi/.cask/bin:$PATH"
    export PYTHONPATH="/home/hebi/.guix-profile/lib/python2.7/site-packages${PYTHONPATH:+:}$PYTHONPATH"
    export GIO_EXTRA_MODULES="/home/hebi/.guix-profile/lib/gio/modules${GIO_EXTRA_MODULES:+:}$GIO_EXTRA_MODULES"

    export poppler_glib_CFLAGS="-I/gnu/store/lk7qa3appvxh6v7iphvkm0v40rv4vbw9-poppler-0.63.0/include/poppler/glib"
    export poppler_glib_LIBS="-L/gnu/store/lk7qa3appvxh6v7iphvkm0v40rv4vbw9-poppler-0.63.0/lib -lpoppler-glib -lpoppler"

    export ASPELL_DICT_DIR="/home/hebi/.guix-profile/lib/aspell"

fi
