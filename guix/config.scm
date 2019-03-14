;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)
             (gnu system nss))

(use-service-modules desktop ssh cgit audio)

(use-package-modules base bash linux ssh perl lisp)

(operating-system
  (host-name "antelope")
  (timezone "America/Chicago")
  (locale "en_US.utf8")
  (kernel linux-libre)
  (kernel-arguments '("intel_iommu=on" "iommu=pt" "modprobe.blacklist=nouveau"))
  (hosts-file (plain-file "my-hosts"
                          (string-join
                           ;; I probably don't need the first two lines
                           '("127.0.0.1 localhost antelope"
                             "::1       localhost antelope"
                             ;; my servers
                             "192.168.1.102 joule"
                             "10.26.52.243 ryzen"
                             "192.168.1.136 pi"
                             "127.0.0.1 git.lihebi.com")
                           "\n")))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (target "/boot/efi")))

  ;; Assume the target root file system is labelled "my-root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (cons* (file-system
                         (device "/dev/sda2")
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         ;; this UUID is returned by sudo blkid
                         (device "/dev/sda1")
                         (mount-point "/boot/efi")
                         (type "vfat"))
                       %base-file-systems))

  (users (cons* (user-account
                 (name "hebi")
                 (comment "Hebi Li")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev" "tty"
                                         ;; "docker"
                                         ;; FIXME run qemu without root?
                                         ;; "libvirtd"
                                         "audio" "video"))
                 (home-directory "/home/hebi"))
                (user-account
                 (name "tester")
                 (comment "Test user")
                 (group "users")
                 (supplementary-groups '("wheel" "netdev"
                                         "audio" "video"))
                 (home-directory "/home/tester"))
                %base-user-accounts))

  (packages (cons*
             sbcl-stumpwm
             %base-packages))

  (services (cons*
             ;; (service docker-service-type)
             ;; TODO see if just evaluating this will add /usr/bin/env
             ;; by default, there is /usr/bin/env and /bin/sh
             (extra-special-file "/usr/bin/env"
                                 (file-append coreutils "/bin/env"))
             (extra-special-file "/bin/rm"
                                 (file-append coreutils "/bin/rm"))
             (extra-special-file "/usr/bin/bash"
                                 (file-append bash "/bin/bash"))
             (extra-special-file "/bin/bash"
                                 (file-append bash "/bin/bash"))
             (extra-special-file "/usr/bin/perl"
                                 (file-append perl "/bin/perl"))
             ;; seems to solve the binary runnable problem
             (extra-special-file "/lib64/ld-linux-x86-64.so.2"
                                 (file-append glibc "/lib/ld-linux-x86-64.so.2"))
             ;; (extra-special-file "/usr/lib/libstdc++.so.6"
             ;;                     (file-append gcc "/libstdc++.so.6"))

             ;; I'm enabling gnome because the screenshot packages and
             ;; qemu seems not working due to incorrect setup of dbus
	     ;; (gnome-desktop-service)
             ;; (mate-desktop-service)
             ;; (enlightenment-desktop-service-type)
             ;; (xfce-desktop-service)

             ;; Must define the ssh daemon here. herd status
             ;; ssh-daemon says it cannot find ssh-daemon
             ;; service. That's because installing openssh locally
             ;; will only work for a local ssh client. The package
             ;; must be installed system-wise to have ssd-daemon.
             ;;
             (service openssh-service-type
                      (openssh-configuration (port-number 22)))

             ;; For http clone, I don't even need a web server like
             ;; Nginx.  I just need cgit service. However, it does
             ;; nothing for hostname resolution.
             (service cgit-service-type
                      (cgit-configuration
                       (clone-prefix '("http://git.lihebi.com"
                                       "ssh:hebi@git.lihebi.com:/srv/git"))
                       (root-readme "README.org")
                       (readme "README.org")
                       (max-stats "year")))
             ;; need this for Nginx to show git.lihebi.com, otherwise
             ;; Nginx 502 gateway error
             ;; (service fcgiwrap-service-type)
             ;; I cannot use SSL certificate yet, thus no push over http
             ;; (service nginx-service-type
             ;;          (nginx-configuration
             ;;           (server-blocks
             ;;            (list
             ;;             (nginx-server-configuration
             ;;              (server-name '("git.lihebi.com"))
             ;;              (locations
             ;;               (list
             ;;                (git-http-nginx-location-configuration
             ;;                 (git-http-configuration (uri-path "/"))))))))))


             (service mpd-service-type
                      (mpd-configuration
                       (user "hebi")
                       (port "6600")))

             ;; desktop services includes the X11 log-in service,
             ;; networking with NetworkManager, and more. Use F1 to
             ;; switch between WMs. Must install WMs in the system
             ;; level, and they should appear in
             ;; /run/current-system/profile/share/xsessions as
             ;; XXX.desktop
	     %desktop-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
