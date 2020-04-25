#!/bin/bash

export EMAIL="lihebi.com@gmail.com"
export NAME="Hebi Li"
export SMTPSERVER="smtp.gmail.com"

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

# pip install --user xxx: will install under this folder
# python3 -m site --user-base: show the local folder
export PATH="$HOME/.local/bin/:$PATH"

# cutensor
export CUTENSOR_ROOT=$HOME/usr/lib/libcutensor
# it looks like ubuntu banned user from setting LD_LIBRARY_PATH in
# profile. https://askubuntu.com/questions/807872/cannot-set-ld-library-path-in-etc-profile-d
# Thus, I should add a conf in /etc/ld.so.conf.d for it, then sudo ldconfig
export LD_LIBRARY_PATH=${CUTENSOR_ROOT}/lib/10.2/:${LD_LIBRARY_PATH}
export JULIA_NUM_THREADS=8

# export LANG=en_US.UTF-8
# export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# FIXME GuixSD name
if hash guix 2>/dev/null; then
    # FIXME should use relative path
    if [ -f "$HOME/git/guix-channel/machine/profile" ]; then
        source "$HOME/git/guix-channel/machine/profile"
    fi
fi
