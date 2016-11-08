#!/bin/bash


# before running this script, you should already installed
# - emacs, git, sudo
# - added your user to sudo group
# - change the package source to testing, and dist upgrade the system

PS3='Whic one? '
desktop_packages=$(cat debian-desktop-package.conf | sed 's/#.*//g' | sed '/^$/d')
desktop_packages+=" linux-headers-$(uname -r)"
server_packages=$(cat debian-server-package.conf | sed 's/#.*//g' | sed '/^$/d')
select machine in 'desktop' 'server' 'git' 'alt' 'repo'; do
    case $machine in
        'desktop')
            echo "Installing desktop packages .."
            echo ${desktop_packages}
            sudo apt-get -y install ${desktop_packages};
            exit 0;;
        'server')
            echo "Installing server packages .."
            echo ${server_packages}
            sudo apt-get -y install ${server_packages};
            exit 0;;
        'git')
            echo "Configuring git .."
            git config --global user.name "Hebi Li";
            git config --global user.email "lihebi.com@gmail.com";
            git config --global credential.helper cache;
            git config --global push.default simple;
            exit 0;;
        'alt')
            echo "Setting alternatives .."
            sudo update-alternatives --config x-terminal-emulator;
            sudo update-alternatives --config x-www-browser;
            exit 0;;
        'repo')
            echo "Cloning configure repos .."
            [ -d ~/.hebi ] || git clone https://github.com/lihebi/dothebi ~/.hebi;
            [ -d ~/.emacs.d ] || git clone https://github.com/lihebi/emacs.d ~/.emacs.d;
            [ -d ~/.stumpwm.d ] || git clone https://github.com/lihebi/stumpwm.d ~/.stumpwm.d;
            [ -d ~/.info ] || git clone https://github.com/lihebi/dotinfo ~/.info;
            exit 0;;
        *)
            echo "invalid";;
    esac
done

# packages=$(cat debian-packages.conf  | sed 's/#.*//g' | sed '/^$/d')
# packages+=" linux-headers-$(uname -r)"
# echo "Installing package: "
# echo $packages
# sudo apt-get -y install $packages

# after this script, you need to do the following additional steps
# - compile and install gtest from source
# - download srcml (http://131.123.42.38/lmcrs/beta/srcML-Ubuntu14.04-64.deb)
# - install translate-shell (wget git.io/trans)
# - compile most recent stumpwm (https://github.com/stumpwm/stumpwm)
# - install quicklisp, and clx-truetype,zpng (ql:quickload "clx-truetype") (ql:quickload "zpng")
# - init the submodules: .stumpwm.d .hebi

