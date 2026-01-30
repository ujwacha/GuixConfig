(use-modules (gnu) 
	     (gnu system nss)
	     (gnu packages ncurses)
	     (nongnu packages linux)
	     (nongnu packages firmware)
	     (nongnu system linux-initrd)
	     (nongnu packages video))


(use-package-modules audio video nfs certs shells ssh linux bash emacs
		     gnome
		     gnome-xyz
                     networking wm fonts libusb cups freedesktop
		     file-systems
                     version-control package-management vim wm)

(use-service-modules
 dbus
 desktop
 ssh
 cups
 pm
 authentication
 databases
 sound
 web)

(use-package-modules
 bootloaders
 certs
 ratpoison
 suckless
 wm
 glib
 xorg)

(operating-system
 (host-name "vogel")
 (timezone "Asia/Kathmandu")
 (locale "en_US.utf8")


 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware
		 sof-firmware))

 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))

 (file-systems (append
		(list 
		 (file-system
		  (mount-point "/")
		  (type "btrfs")
		  (device
		   (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
		  (options "subvol=@"))

		 (file-system
		  (mount-point "/home")
		  (type "btrfs")
		  (device
		   (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
		  (options "subvol=@home"))


		 (file-system
		  (mount-point "/.snapshots")
		  (type "btrfs")
		  (device
		   (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
		  (options "subvol=@snapshots"))


                 (file-system
                  (device (uuid "EAA5-790E" 'fat))
                  (mount-point "/boot/efi")
                  (type "vfat"))


		 (file-system
		  (mount-point "/gnu/store")
		  (type "btrfs")
		  (device
		   (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
		  (options "subvol=@store")))
		%base-file-systems))

 (swap-devices 
  (list
   (swap-space (target 
		(uuid "74d60df6-0325-496e-800b-20608cc595a1")))))


 (users (cons (user-account
	       (name "light")
	       (comment "Main User")
	       (group "users")
	       (supplementary-groups '("wheel" "netdev"
				       "audio" "video"
				       "dialout")))
	      %base-user-accounts))

 (packages (append (list
		    i3-wm i3status dmenu i3blocks
		    ;;emacs emacs-exwm emacs-desktop-environment
		    ;; terminal emulator
		    xterm
		    ncurses
		    dbus
		    bluez
                    bluez-alsa
                    brightnessctl
                    exfat-utils
                    fuse-exfat
                    git
                    gvfs ;; Enable user mounts
                    intel-media-driver/nonfree
                    libva-utils
                    ntfs-3g
                    stow
                    vim
		    ;;sway
		    papersway
		    swaylock
		    swayidle
		    swayfx
		    mako
		    niri
		    gnome-shell-extension-vitals
		    gnome-shell-extension-gsconnect
		    gnome-shell-extension-just-perfection
		    gnome-shell-extension-paperwm
		    gnome-shell-extension-appindicator
		    tlp
		    ;;power-profiles-daemon
		    )
		   %base-packages))

 (services 
  (append (list
	   (service openssh-service-type)
	   (service cups-service-type)

	   
	   (service gnome-desktop-service-type)
	   

	   (service tlp-service-type
		    (tlp-configuration


		     (tlp-enable? #t)

		     (tlp-default-mode "AC")

		     (start-charge-thresh-bat0 74)
		     (stop-charge-thresh-bat0 84)
		     

		     (cpu-scaling-governor-on-ac '("performance"))
		     (cpu-scaling-governor-on-bat '("powersave"))

		     (cpu-energy-perf-policy-on-ac "performance")
		     (cpu-energy-perf-policy-on-bat "power")
		     

		     (cpu-boost-on-ac? #t)
		     (cpu-boost-on-bat? #f)
		     
		     (sched-powersave-on-bat? #t)))
	  ;; Add platform profile settings via drop-in file
	   (extra-special-file
	    "/etc/tlp.d/50-platform-profile.conf"
            (plain-file "50-platform-profile.conf"
			"PLATFORM_PROFILE_ON_AC=performance\nPLATFORM_PROFILE_ON_BAT=low-power\n"))


	   ;; (service power-profiles-daemon-service-type)



	   ;; (service fprintd-service-type)

	   (service mysql-service-type)

	   (service bluetooth-service-type
                    (bluetooth-configuration
                     (auto-enable? #t)))

	   
	   )
 
	  (modify-services
	   %desktop-services

	   (guix-service-type config =>
			      (guix-configuration
			       (inherit config)
			       (substitute-urls 
				(append
				 (list
				  "https://bordeaux-singapore-mirror.cbaines.net"
				  "https://mirror.sjtu.edu.cn/guix" 
				  "https://substitutes.nonguix.org"
				  ;; "https://bordeaux.guix.gnu.org"
				  )
				 %default-substitute-urls
				 ;;'() ;; i have the german server
				 ))
			       (authorized-keys
				(append
				 (list (local-file "./signing-key.pub"))
				 %default-authorized-guix-keys))
			       )))))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
;;
