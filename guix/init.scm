;; for system init

(use-modules (gnu)
             (srfi srfi-1)
             (guix profiles)
             (guix packages))

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
  (file-systems (cons* (file-system
                         (device "/dev/sda2")
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device "/dev/sda1")
                         (mount-point "/boot/efi")
                         (type "vfat"))
                       %base-file-systems))
  (host-name "antelope")
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
    (list
     (service openssh-service-type))
    %desktop-services)))
