#!/bin/bash

INSTALL="sudo pacman -S --needed --noconfirm"

$INSTALL base-devel cmake pugixml ninja
$INSTALL gtest antlr2 rapidjson libxslt

$INSTALL xorg
$INSTALL xorg-xinit

$INSTALL xorg-xinit
$INSTALL xorg-server xorg-xinit xterm rxvt-unicode xorg-xinput
$INSTALL xorg-xdm xorg-xconsole
$INSTALL openbox
$INSTALL xorg-twm xorg-xterm xorg-xclock xorg-xkill
$INSTALL xorg-xeyes xorg-xcalc xorg-xconsole
$INSTALL xorg-server-devel

$INSTALL ghostscript # for ps2pdf
$INSTALL sbcl bc git curl mlocate bash-completion
$INSTALL ctags the_silver_searcher python python2
$INSTALL python-pip ipython ispell aspell aspell-en
$INSTALL feh tidy unzip cloc svn ntfs-3g openssh
$INSTALL clojure r youtube-dl

$INSTALL spice # the command is remove-viewer
$INSTALL virt-viewer
$INSTALL ruby markdown
$INSTALL dosfstools # for mkfs.vfat, used for raspberry pi
$INSTALL pavucontrol pulseaudio alsa-utils pulseaudio-alsa
$INSTALL racket racket-docs swi-prolog


# $INSTALL doxygen gperftools valgrind
$INSTALL emacs tmux mplayer chromium

# $INSTALL firefox # (do not install if I only want to use chromium)

# mpd GUI client, requires pretty much dependencies, based on qt
$INSTALL mpd cantata

$INSTALL texlive-most clang llvm clang-tools-extra boost

$INSTALL acpi # battery
$INSTALL acpid # power management daemon

# pdftools
$INSTALL libzip poppler-glib imagemagick

# NVIDIA
# $INSTALL nvidia nvidia-settings

$INSTALL dialog iw wpa_supplicant

$INSTALL audacity

# without this font file, n1256 would show bad in pdf-tools
$INSTALL ttf-dejavu
# sendmail alternative for supporting multi SMTP servers
$INSTALL msmtp

$INSTALL ghc cabal-install
# stack
# alex happy
$INSTALL gdb
