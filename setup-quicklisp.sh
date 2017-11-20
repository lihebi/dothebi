#!/bin/bash

# this is still interactive
# the path is only for archlinux
sudo sbcl --load /usr/lib/quicklisp/setup\
     --eval '(ql:quickload "clx-truetype")'\
     --eval '(ql:quickload "zpng")'\
     --eval '(ql:quickload "alexandria")'\
     --eval '(ql:quickload "swank")'
     -non-interactive
