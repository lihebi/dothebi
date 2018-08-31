;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)
             (gnu system nss))

(use-service-modules desktop ssh)

(use-package-modules certs ratpoison gnome base suckless wm
                     bootloaders)

(operating-system
  (host-name "antelope")
  (timezone "America/Chicago")
  (locale "en_US.utf8")

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (target "/boot/efi")))

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
                        ;; this UUID is returned by sudo blkid
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
                   ;; FIXME not sure if I need to have this for
                   ;; openssh service to work
                   ;; openssh
                   %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with NetworkManager, and more.
  (services (cons*
             ;; TODO now I'm using ~/.xsession to load StumpWM. How
             ;; can it be done in the login manager level, where I can
             ;; choose different WM besides StumpWM?
             ;; 
	     ;; (gnome-desktop-service)
             (xfce-desktop-service)
             ;; (dhcp-client-service)
             ;;
             ;; Must define the ssh daemon here. herd status
             ;; ssh-daemon says it cannot find ssh-daemon
             ;; service. That's because installing openssh locally
             ;; will only work for a local ssh client. The package
             ;; must be installed system-wise to have ssd-daemon.
             ;;
             (service openssh-service-type
                      (openssh-configuration (port-number 22)))
             ;; FIXME what kind of desktop service?
	     %desktop-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))

;; The following packages should be installed on a user basis
;;
;; FIXME how to declare a local package list to install automatically?

;; make
;; gcc-toolchain
;; libstdc++
;; grep
;; sed
;; coreutils
;; install stumpwm using quicklisp
;; sbcl-stumpwm
;; pkg-config
;; font-wqy-microhei
;; font-wqy-zenhei

;; the-silver-searcher
;; emacs
;; git
;; icecat
;; rxvt-unicode
;; pavucontrol
;; xrdb
;; xmodmap
;; xinput
;; translate-shell
;; bc
;; curl
;; sbcl
;; tmux
;; autoconf
;; automake
;; autobuild
;; gcc
;; poppler
;; zlib
;; libpng
;; gfortran
;; llvm
;; clang
;; imagemagick
;; python
;; bash
;; glibc
;; binutils
;; fontconfig
;; cairo
;; aspell               ; for ispell executable in flyspell-mode
;; aspell-dict-en
;; qemu
;; thunar
;; feh
;; msmtp
;; xrandr
