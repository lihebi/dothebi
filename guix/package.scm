;; Install by guix package -m package.scm

;; (use-package-modules guile emacs)

;; disabled
;; '("icecat" "conkeror")

;; Do not install these!!
;; '("autobuild")

(specifications->manifest
 (append
  ;; essential packages
  '("emacs" "git" "nss-certs" "glibc-locales")
  ;; for emacs-guix on foreign distribution, otherwise emacs-guix will
  ;; complain for undefined variables. See
  ;; https://github.com/alezost/guix.el#important-note-for-non-guixsd-users
  '("guile" "guix")
  ;; cmd utilities
  '("grep" "sed" "coreutils" "bc"
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
    ;; "glibc"
    "bison" "flex"
    "pkg-config" "make" "cmake" "autoconf" "automake"
    ;; I should not install gcc, but gcc-toolchain, according to a
    ;; mailing list post (TODO: cite)
    ;; "gcc" "libstdc++"
    ;;
    ;; seems that gcc-toolchain does not contains "gcc:lib",
    ;; e.g. libgomp.so
    "gcc:lib"
    ;; gcc-toolchain contains "binutils"
    "gcc-toolchain"
    ;; "glib"
    ;; java
    "ant" "icedtea" "icedtea:jdk" "maven"
    "libxtst"                           ; for IntelliJ
    )
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
    "thunar" "tumbler"
    ;; FOREIGN "gnome-icon-theme"
    ;; "nautilus" conflicting with xdg-desktop-database
    ;; "nautilus"
    "vinagre" "feh"
    "xrandr"
    ;; "openbox"
    "xrdb" "xmodmap"
    
    ;; terminal emulators
    "rxvt-unicode"
    "st"
    ;; "cool-retro-term"                   ; not working, when it's working, huge resource consumption
    ;; "kitty"                             ; not working due to opengl issue
    
    ;; an image viewer
    "ristretto"
    ;; fonts (chromium is not getting monospace fonts correctly)
    "xlsfonts" "xset"
    "font-anonymous-pro" "font-fira-mono" "font-dejavu"
    ;; screenshot. Also: maim
    "flameshot" "gnome-screenshot" "arandr")
  '("sbcl")
  ;; service
  '("openssh" "openssl")
  ;; vm
  ;; FOREIGN '("docker" "containerd" "docker-cli" "docker-compose")
  ;; pdftools
  '("imagemagick" "cairo" "libpng" "zlib" "poppler")
  ;; large libraries
  ;; '("llvm" "clang")
  ;; require channel https://gitlab.com/mbakke/guix-chromium.git
  ;; FOREIGN '("chromium")
  ;; the offical ungoogle-chromium released, but seems to crash on my side
  ;; FOREIGN '("xf86-video-nouveau")
  ;; large apps
  ;; FOREIGN '("kicad" "kicad-symbols" "libreoffice")
  ;; "kicad-library" is 4.x
  '("texlive")
  ;; stumpwm
  '("stumpwm")
  ;; stumpwm required libraries
  '("sbcl-slime-swank" "cl-trivial-features")
  ;; from my channel https://github.com/lihebi/guix-channel.git
  '("cl-clx-truetype" "sbcl-zpng")
  ;; other
  '("fontconfig" "qemu" "font-wqy-microhei" "font-wqy-zenhei"
    "linux-pam" "file" "shepherd")))
