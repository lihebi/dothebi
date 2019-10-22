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
export PATH="/home/hebi/.local/bin/:$PATH"

# export LANG=en_US.UTF-8
# export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# FIXME GuixSD name
if hash guix 2>/dev/null; then
    # FIXME should use relative path
    source "$HOME/.hebi/guix/profile"
fi
