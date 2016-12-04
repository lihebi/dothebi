#!/bin/bash


# before running this script, you should already installed
# - emacs, git, sudo
# - added your user to sudo group
# - change the package source to testing, and dist upgrade the system

PS3='Whic one? '
desktop_packages=$(cat debian-desktop-package.conf | sed 's/#.*//g' | sed '/^$/d')
desktop_packages+=" linux-headers-$(uname -r)"
server_packages=$(cat debian-server-package.conf | sed 's/#.*//g' | sed '/^$/d')
select machine in 'desktop' 'server' 'git' 'alt' 'repo' 'additional' 'quicklisp'; do
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
            if ! [ -d ~/.hebi ]; then
                git clone https://github.com/lihebi/dothebi ~/.hebi
                cd ~/.hebi
                git submodule init
                git submodule update
                # ./install
            fi
            if ! [ -d ~/.stumpwm.d ]; then
                git clone https://github.com/lihebi/stumpwm.d ~/.stumpwm.d;
                cd ~/.stumpwm.d
                git submodule init
                git submodule update
            fi
            [ -d ~/.emacs.d ] || git clone https://github.com/lihebi/emacs.d ~/.emacs.d;
            [ -d ~/.info ] || git clone https://github.com/lihebi/dotinfo ~/.info;
            exit 0;;
        'additional')
            # - compile and install gtest from source
            cd /tmp
            mkdir build
            cd build
            cmake /usr/src/gtest
            make
            sudo mv libgtest* /usr/local/lib
            # - download srcml (http://131.123.42.38/lmcrs/beta/srcML-Ubuntu14.04-64.deb)
            wget http://131.123.42.38/lmcrs/beta/srcML-Ubuntu14.04-64.deb -O /tmp/srcml.deb
            sudo dpkg -i /tmp/srcml.deb
            # - install translate-shell (wget git.io/trans)
            mkdir ~/bin
            wget git.io/trans ~/bin
            chmod a+x ~/bin/trans
            # - compile most recent stumpwm (https://github.com/stumpwm/stumpwm)
            git clone https://github.com/stumpwm/stumpwm /tmp/stumpwm
            cd /tmp/stumpwm
            ./autogen.sh
            ./configure
            make
            sudo make install
            exit 0;;
        'quicklisp')
            cd /tmp
            curl -O https://beta.quicklisp.org/quicklisp.lisp
            sbcl --load quicklisp.lisp --eval "(quicklisp-quickstart:install)"\
                 --eval '(ql:quickload "clx-truetype")'\
                 --eval '(ql:quickload "zpng")' --non-interactive
            # sbcl --load quicklisp.lisp --script $HOME/.hebi/install-lisp.cl
            exit 0;;
        *)
            echo "invalid";;
    esac
done

# - install quicklisp, and clx-truetype,zpng (ql:quickload "clx-truetype") (ql:quickload "zpng")
# curl -O https://beta.quicklisp.org/quicklisp.lisp
# sbcl --load quicklisp.lisp --script install-lisp.cl
# (quicklisp-quickstart:install)
# (ql:quickload "clx-truetype")
# (ql:quickload "zpng")
