#!/bin/bash

# this is still interactive
# the path is only for archlinux
# sudo sbcl --quit --load /usr/lib/quicklisp/setup\
    
# in case of GuixSD, the sbcl-stumpwm package already has the
# following three packages, so if install them again, common lisp will
# complain
    
     # --eval '(ql:quickload "clx")'\
     # --eval '(ql:quickload "cl-ppcre")'\
     # --eval '(ql:quickload "alexandria")'\
     # --eval '(ql:quickload "stumpwm")'\
     
sbcl --quit\
     --eval '(ql:quickload "clx-truetype")'\
     --eval '(ql:quickload "zpng")'\
     --eval '(ql:quickload "swank")'\
     -non-interactive
