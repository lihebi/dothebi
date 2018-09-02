;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)
             (gnu system nss))

(use-service-modules desktop ssh cgit version-control web)

(use-package-modules certs gnome base suckless wm
                     lisp openbox version-control)

;; TODO see if just evaluating this will add /usr/bin/env
;; (extra-special-file "/usr/bin/env"
;;                     (file-append coreutils "/bin/env"))

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
               (comment "Hebi Li")
               (group "users")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video"))
               (home-directory "/home/hebi"))
              %base-user-accounts))

 (packages (cons*
            ;; for HTTPS access
            nss-certs
            git
            emacs
            ;; this stumpwm should wirte Stumpwm.desktop
            sbcl-stumpwm
            ;;
            ;; this is the cl package, not the WM
            ;; cl-stumpwm
            openbox
            %base-packages))

 (services (cons*
	    ;; (gnome-desktop-service)
            ;; (mate-desktop-service)
            ;; (enlightenment-desktop-service-type)
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

            ;; for configuring cgit interface
            (service cgit-service-type
                     (cgit-configuration
                      (clone-prefix '("http://git.lihebi.com"
                                      "ssh:hebi@git.lihebi.com:/srv/git"))
                      (root-readme "README.org")
                      (readme "README.org")
                      (max-stats "year")))
            ;; need this for Nginx to show git.lihebi.com, otherwise
            ;; Nginx 502 gateway error
            (service fcgiwrap-service-type)
            ;; I cannot use SSL certificate yet, thus no push over http
            (service nginx-service-type
                     (nginx-configuration
                      (server-blocks
                       (list
                        (nginx-server-configuration
                         (server-name '("git.lihebi.com"))
                         (locations
                          (list
                           (git-http-nginx-location-configuration
                            (git-http-configuration (uri-path "/"))))))))))


            ;; desktop services includes the X11 log-in service,
            ;; networking with NetworkManager, and more. Use F1 to
            ;; switch between WMs. Must install WMs in the system
            ;; level, and they should appear in
            ;; /run/current-system/profile/share/xsessions as
            ;; XXX.desktop
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
