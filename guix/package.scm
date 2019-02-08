;; Install by guix package -m package.scm

;; (use-package-modules guile emacs)

;; disabled
;; '("icecat" "conkeror")

;; Do not install these!!
;; '("autobuild" "libstdc++")

(specifications->manifest
 (append
  ;; essential packages
  '("emacs" "git" "nss-certs")
  ;; cmd utilities
  '("grep" "sed" "coreutils" "binutils" "bc"
    "aspell" "aspell-dict-en" ; for ispell executable in flyspell-mode
    "msmtp" "iptables"
    "the-silver-searcher" "translate-shell"
    "htop" "curl" "tmux")
  ;; compiler toolchain
  '("gcc-toolchain" ; seems this contains "as", necessary for compilation
    "pkg-config" "make" "cmake" "autoconf" "automake" "gcc" "glibc" "glib")
  ;; languages
  '("python" "bash")
  ;; X11 utilities
  '("alsa-utils" "pavucontrol"
    "xinput" "gfortran"
    "thunar" "nautilus"
    "vinagre" "feh"
    "xrandr" "openbox" "rxvt-unicode" "xrdb" "xmodmap")
  '("sbcl")
  ;; service
  '("openssh" "openssl")
  ;; vm
  '("docker" "docker-cli" "docker-compose")
  ;; pdftools
  '("imagemagick" "cairo" "libpng" "zlib" "poppler")
  ;; other
  '("fontconfig" "qemu" "font-wqy-microhei" "font-wqy-zenhei")
  ;; large libraries
  ;; '("llvm" "clang")
  ;; require channel https://gitlab.com/mbakke/guix-chromium.git
  '("chromium")
  ;; stumpwm
  '("stumpwm")
  ;; stumpwm required libraries
  '("sbcl-slime-swank" "cl-trivial-features")
  ;; from my channel https://github.com/lihebi/guix-channel.git
  '("cl-clx-truetype" "sbcl-zpng")))
