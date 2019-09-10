(bootloader (bootloader-configuration
             (bootloader grub-efi-bootloader)
             (target "/boot/efi")
             (menu-entries
              (list
               ;; (menu-entry
               ;;  (label "The Other Distro")
               ;;  (linux "/boot/old/vmlinux-2.6.32")
               ;;  (linux-arguments '("root=/dev/sda2"))
               ;;  (initrd "/boot/old/initrd"))
               (menu-entry
                (label "Without Nouveau")
                (linux (file-append linux-libre "/bzImage"))
                (linux-arguments
                 '("modprobe.blacklist=nouveau"
                   ;; FIXME use the value from file-systems field?
                   "--root=/dev/sda2"
                   ;; FIXME use the current link?
                   ;; (string-append "--system=" (file-append system ""))
                   "--system=/var/guix/profiles/system-11-link"
                   ;; #~(string-append "--system=" #$system)
                   "--load=/var/guix/profiles/system-11-link/boot"
                   ;; #~(string-append "--load=" #$system "/boot")
                   ))
                ;; FIXME
                ;; (initrd "/boot/old/initrd")
                (initrd "/gnu/store/d8p8d7j2l04nvvpdbxjdfn091zvrw40i-raw-initrd/initrd.cpio.gz")
                ;; (initrd (file-append raw-initrd "/initrd.cpio.gz"))
                )))))


;; I'm taking my original file-systems here, because my new system
;; used graphical installer, and obtained uuid as hard drive
;; identitifer

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


(packages (cons* stumpwm %base-packages))
