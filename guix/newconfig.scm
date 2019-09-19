;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
             (srfi srfi-1)
             (guix profiles)
             (guix packages)
             (nvidia))

(use-service-modules desktop networking ssh xorg web)
(use-package-modules base bash linux ssh perl lisp)

(operating-system
 (locale "en_US.utf8")
 (timezone "America/Chicago")
 (kernel linux-libre)
 (initrd-modules %base-initrd-modules)

 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (target "/boot/efi")))
 (swap-devices (list "/dev/sda3"))
 (file-systems
  (cons* (file-system
          (mount-point "/")
          (device
           (uuid "2ca9f231-8850-479f-bf7d-c7a3ccac5205"
                 'ext4))
          (type "ext4"))
         (file-system
          (mount-point "/boot/efi")
          (device (uuid "9AD3-2CAE" 'fat32))
          (type "vfat"))
         (file-system
          (mount-point "/home")
          (device
           (uuid "ff1d452f-7748-4736-9b3e-8f797bd5e7c9"
                 'ext4))
          (type "ext4"))
         %base-file-systems))
 (host-name "ryzen")
 (users (cons* (user-account
                (name "hebi")
                (comment "Hebi Li")
                (group "users")
                (home-directory "/home/hebi")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video")))
               %base-user-accounts))
 (packages
  (append
   (list (specification->package "openbox")
         (specification->package "ratpoison")
         (specification->package "stumpwm")
         (specification->package "xmonad")
         (specification->package "sway")
         (specification->package "nss-certs"))
   %base-packages))
 (services
  (append
   (list
    (service gnome-desktop-service-type)
    (service nginx-service-type
             (nginx-configuration
              (server-blocks
               (list
                (nginx-server-configuration
                 ;; FIXME ssl https. This is critical, otherwise nginx
                 ;; config test fail and service cannot be started
                 (listen '("80"))
                 ;; FIXME localhost? This does not seem important
                 (server-name '("localhost"))
                 ;; Cannot use a home directory such as ~/git/www,
                 ;; because x permission is not set for ~ for user
                 ;; nginx
                 (root "/src/www"))))))
    (service hello-service-type)
    (service openssh-service-type))
   %desktop-services)))
