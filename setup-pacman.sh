#!/bin/bash

INSTALL="sudo pacman -S --needed --noconfirm"

$INSTALL\
    base-devel cmake pugixml ninja\
    gtest antlr2 rapidjson libxslt

$INSTALL\
    xorg\
    xorg-xinit\
    xorg-server xorg-xinit xterm rxvt-unicode xorg-xinput\
    xorg-xdm xorg-xconsole\
    openbox\
    xorg-twm xorg-xterm xorg-xclock xorg-xkill\
    xorg-xeyes xorg-xcalc xorg-xconsole\
    xorg-server-devel

$INSTALL ghostscript # for ps2pdf
$INSTALL sbcl bc git curl mlocate bash-completion\
         ctags the_silver_searcher python python2\
         python-pip ipython ispell aspell aspell-en\
         feh tidy unzip cloc svn ntfs-3g openssh\
         clojure r youtube-dl
$INSTALL spice # the command is remove-viewer
$INSTALL virt-viewer
$INSTALL ruby markdown
$INSTALL dosfstools # for mkfs.vfat, used for raspberry pi
$INSTALL pavucontrol pulseaudio alsa-utils pulseaudio-alsa\
         racket racket-docs swi-prolog


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
