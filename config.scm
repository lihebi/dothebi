;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)
             (gnu system nss))

(use-service-modules desktop)

(use-package-modules bootloaders certs ratpoison suckless wm
		     gnome base
                     lisp code shells fonts emacs version-control
                     gnuzilla xdisorg pulseaudio xorg dictionaries
                     algebra curl tmux autotools gcc pdf
                     compression image  llvm imagemagick
                     python bash)

(operating-system
  (host-name "antelope")
  (timezone "America/Chicago")
  (locale "en_US.utf8")

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (target "/boot/efi")))

  (initrd-modules (append (list "ahci" "shpchp")
                                %base-initrd-modules))

  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (cons* (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (file-system-label "my-home"))
                         (mount-point "/home")
                         (type "ext4"))
                       (file-system
                         (device (uuid "9AD3-2CAE" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat"))
                       %base-file-systems))

  (users (cons (user-account
                (name "hebi")
                (comment "Hahaha")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/hebi"))
               %base-user-accounts))

  ;; Add a bunch of window managers; we can choose one at
  ;; the log-in screen with F1.
  (packages (cons* ratpoison i3-wm i3status dmenu ;window managers
                   nss-certs                      ;for HTTPS access
                   ;; packages other than window managers
                   the-silver-searcher
                   font-wqy-microhei
                   font-wqy-zenhei
                   emacs
                   git
                   icecat
                   rxvt-unicode
                   pavucontrol
                   xrdb
                   xmodmap
                   xinput
                   translate-shell
                   bc
                   curl
                   sbcl
                   tmux
                   autoconf
                   automake
                   autobuild
                   gcc
                   pkg-config
                   poppler
                   zlib
                   libpng
                   gfortran
                   llvm
                   clang
                   imagemagick
                   python
                   bash
                   glibc
                   binutils
                   fontconfig
                   cairo
                   aspell               ; for ispell executable in flyspell-mode
                   aspell-dict-en
                   qemu
                   thunar
                   feh
                   msmtp
                   xrandr
                   ;; make
                   ;; gcc-toolchain
                   ;; libstdc++
                   ;; grep
                   ;; sed
                   ;; coreutils
                   ;; install stumpwm using quicklisp
                   ;; sbcl-stumpwm
                  %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with NetworkManager, and more.
  (services (cons*
	     (gnome-desktop-service)
	     %desktop-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
