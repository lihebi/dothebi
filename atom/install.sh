#!/bin/sh

ln -sf $HOME/.hebi/atom/styles.less $HOME/.atom/styles.less
ln -sf $HOME/.hebi/atom/keymap.cson $HOME/.atom/keymap.cson

rm -rf $HOME/.atom/packages/*

apm install minimap
apm install zentabs
apm install language-latex
apm install color-picker
apm install project-manager
apm install resize-panes
apm install atom-beautify
apm install html-entities
apm install linter
apm install autocomplete-plus
