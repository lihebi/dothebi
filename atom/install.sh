#!/bin/sh

ln -sf $HOME/.hebi/atom/styles.less $HOME/.atom/styles.less
ln -sf $HOME/.hebi/atom/keymap.cson $HOME/.atom/keymap.cson

apm install minimap
apm install zentabs
apm install language-latex
apm install color-picker
apm install atom-html-preview
apm install project-manager
apm install resize-panes
