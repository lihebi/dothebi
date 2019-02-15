;; Install by guix package -m package.scm

;; (use-package-modules guile emacs)

;; disabled
;; '("icecat" "conkeror")

;; Do not install these!!
;; '("autobuild")

(specifications->manifest
 (append
  ;; essential packages
  '("emacs" "git" "nss-certs")
  ;; cmd utilities
  '("grep" "sed" "coreutils" "binutils" "bc"
    "aspell" "aspell-dict-en" ; for ispell executable in flyspell-mode
    "msmtp" "iptables"
    "the-silver-searcher" "translate-shell"
    "htop" "curl" "tmux" "parted" "gparted" "unzip")
  ;; compiler toolchain
  '(
    ;; seems this contains "as", necessary for compilation
    ;; "gcc-toolchain"
    ;;
    ;; seems glibc contains ld-linux-x86-64.so.2, ldd, as, overlapping
    ;; with gcc-tooltain
    "glibc"
    "bison" "flex"
    "pkg-config" "make" "cmake" "autoconf" "automake"
    "gcc" "gcc:lib"
    "glib"
    ;; java
    "ant" "icedtea" "icedtea:jdk")
  ;; languages
  '("python" "bash" "perl")
  ;; tk of python. Seems the python:tk does the trick
  '("tk" "tklib" "python:tk")
  ;; X11 utilities
  '("alsa-utils" "pavucontrol"
    "ncurses"
    "xinput"
    ;; "gfortran"
    ;;
    ;; thunar seems to be with xfce, and it does not have a icon
    ;; theme. The solution is to use gnome icons by adding
    ;; ~/.gtkrc-2.0 with gtk-icon-theme-name="gnome"
    "thunar"
    "nautilus" "gnome-icon-theme"
    "vinagre" "feh"
    "xrandr"
    ;; "openbox"
    "rxvt-unicode" "xrdb" "xmodmap"
    ;; an image viewer
    "ristretto"
    ;; fonts (chromium is not getting monospace fonts correctly)
    "xlsfonts" "xset"
    "font-anonymous-pro" "font-fira-mono" "font-dejavu"
    ;; screenshot. Also: maim
    "flameshot" "gnome-screenshot")
  '("sbcl")
  ;; service
  '("openssh" "openssl")
  ;; vm
  '("docker" "containerd" "docker-cli" "docker-compose")
  ;; pdftools
  '("imagemagick" "cairo" "libpng" "zlib" "poppler")
  ;; large libraries
  ;; '("llvm" "clang")
  ;; require channel https://gitlab.com/mbakke/guix-chromium.git
  '("chromium")
  '("xf86-video-nouveau")
  ;; stumpwm
  '("stumpwm")
  ;; stumpwm required libraries
  '("sbcl-slime-swank" "cl-trivial-features")
  ;; from my channel https://github.com/lihebi/guix-channel.git
  '("cl-clx-truetype" "sbcl-zpng")
  ;; other
  '("fontconfig" "qemu" "font-wqy-microhei" "font-wqy-zenhei"
    "linux-pam" "file" "libstdc++" "shepherd")))
