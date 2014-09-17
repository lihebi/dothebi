#!/bin/bash
mv $HOME/.atom/styles.less $HOME/.atom/styles.less-bak
mv $HOME/.atom/keymap.cson $HOME/.atom/keymap.cson-bak
ln -s $HOME/.hebi/atom/styles.less $HOME/.atom/styles.less
ln -s $HOME/.hebi/atom/keymap.cson $HOME/.atom/keymap.cson
