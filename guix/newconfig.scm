;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)
(use-package-modules base bash linux ssh perl lisp)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/Chicago")
  ;; (keyboard-layout
  ;;   (keyboard-layout "us" "altgr-intl"))
  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (target "/boot/efi")
    ;; (keyboard-layout keyboard-layout)
    ))
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
          (specification->package "nss-certs"))
    %base-packages))
  (services
   (append
    (list (service gnome-desktop-service-type)
          (service openssh-service-type)
          ;; (set-xorg-configuration
          ;;   (xorg-configuration
          ;;    (keyboard-layout keyboard-layout)))
          )
    %desktop-services)))
