#!/bin/bash

# this is still interactive
# the path is only for archlinux
# sudo sbcl --quit --load /usr/lib/quicklisp/setup\
sbcl --quit\
     --eval '(ql:quickload "clx")'\
     --eval '(ql:quickload "cl-ppcre")'\
     --eval '(ql:quickload "alexandria")'\
     --eval '(ql:quickload "clx-truetype")'\
     --eval '(ql:quickload "stumpwm")'\
     --eval '(ql:quickload "zpng")'\
     --eval '(ql:quickload "swank")'\
     -non-interactive
