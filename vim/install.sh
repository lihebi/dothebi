#!/bin/sh

ln -sf $HOME/.hebi/rc/vimrc $HOME/.vimrc

rm -rf $HOME/.vim
VUNDLE_URI="https://github.com/gmarik/vundle.git"
git clone $VUNDLE_URI $HOME/.vim/bundle/vundle
