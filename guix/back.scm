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

