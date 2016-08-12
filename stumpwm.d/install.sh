#!/bin/bash

rm -rf $HOME/.stumpwmrc
rm -rf $HOME/.stumpwm.d
ln -s $HOME/.hebi/stumpwm.d/stumpwmrc $HOME/.stumpwmrc
ln -s $HOME/.hebi/stumpwm.d $HOME/.stumpwm.d
