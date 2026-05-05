(use-modules (gnu) 
	     (gnu system nss)
	     (gnu system accounts)
	     (gnu packages ncurses)
	     (nongnu packages linux)
	     (nongnu packages firmware)
	     (nongnu system linux-initrd)
	     (nongnu packages video))


(use-package-modules audio
		     video
		     nfs
		     certs
		     shells
		     ssh
		     linux
		     bash
		     emacs
		     gnome
		     gnome-xyz
		     emacs-xyz
                     networking
		     wm
		     containers
		     fonts
		     libusb
		     cups
		     databases
		     freedesktop
		     file-systems
                     version-control
		     package-management
		     vim
		     virtualization
		     docker
		     wm)

(use-service-modules dbus
		     desktop
		     ssh
		     cups
		     pm
		     authentication
		     xorg
		     containers
		     databases
		     sound
		     web
		     virtualization
		     docker
		     networking)

(use-package-modules bootloaders
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

 (kernel-arguments (append '("resume=607f7910-12e6-404f-8664-70fa0c0f8776")
			   %default-kernel-arguments))
 
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
 		 (options "subvol=@,compress=zstd,discard=async,space_cache=v2"))
 		
 		(file-system
 		 (mount-point "/home")
 		 (type "btrfs")
 		 (device
 		  (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
 		 (options "subvol=@home,compress=zstd,discard=async,space_cache=v2"))
 		
 		(file-system
 		 (mount-point "/.snapshots")
 		 (type "btrfs")
 		 (device
 		  (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
 		 (options "subvol=@snapshots,compress=zstd,discard=async,space_cache=v2"))
 		
 		(file-system
 		 (mount-point "/gnu/store")
 		 (type "btrfs")
 		 (device
 		  (uuid "92b39d97-81c5-4ef5-ba2f-51600140f500"))
 		 (options "subvol=@store,compress=zstd,discard=async,space_cache=v2"))
 		
 		(file-system
 		 (device (uuid "EAA5-790E" 'fat))
 		 (mount-point "/boot/efi")
 		 (type "vfat"))
 		)
 	       %base-file-systems))
 (swap-devices 
   (list
    (swap-space (target 
 		(uuid "607f7910-12e6-404f-8664-70fa0c0f8776")))))

 (groups (cons* ;; (user-group (name "libvirt"))
 	       ;; (user-group (name "cgroup"))
                %base-groups))
 
 (users (append (list
 		(user-account
 		 (name "light")
 		 (comment "Main User")
 		 (group "users")
 		 (supplementary-groups '("wheel" "netdev"
 					 "audio" "video"
 					 "dialout" "libvirt"
 					 "kvm" "cgroup"
 					 "docker")))
 		(user-account
 		 (name "study")
 		 (comment "Study User")
 		 (group "users")
 		 (supplementary-groups '("wheel" "netdev"
 					 "audio" "video"
 					 "dialout")))
 		)
 	       %base-user-accounts))

 (packages (append (list
 		   fwupd-nonfree
 		   i3-wm i3status dmenu i3blocks
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
 		   swaylock
 		   swayidle
 		   sway
 		   xdg-dbus-proxy
 		   xdg-desktop-portal
 		   xdg-desktop-portal-gtk
 		   xdg-desktop-portal-wlr
 		   mako
 		   niri
 		   gnome-shell-extension-vitals
 		   gnome-shell-extension-gsconnect
 		   gnome-shell-extension-just-perfection
 		   gnome-shell-extension-paperwm
 		   gnome-shell-extension-appindicator
 		   distrobox
 		   docker
 		   qemu
 		   virt-manager
 		   tlp
 		   podman
 		   ;;power-profiles-daemon
 		   )
 		  %base-packages))

 (services
  (append (list
 	  (service openssh-service-type)
 	  (service gnome-desktop-service-type)
 	  (service cups-service-type)
 	  (service tlp-service-type
 	    (tlp-configuration
 	      (tlp-enable? #t)
 	      (tlp-default-mode "AC")
 	      (start-charge-thresh-bat0 84)
 	      (stop-charge-thresh-bat0 94)
 	      
 	      (cpu-scaling-governor-on-ac '("performance"))
 	      (cpu-scaling-governor-on-bat '("powersave"))
 	      (cpu-energy-perf-policy-on-ac "performance")
 	      (cpu-energy-perf-policy-on-bat "power")
 	      
 	      (cpu-scaling-max-freq-on-ac 4200000)
 	      (cpu-scaling-max-freq-on-bat 900000)
 	      
 	      (cpu-boost-on-ac? #t)
 	      (cpu-boost-on-bat? #f)
 	    ))
 	  
 	  (extra-special-file
 	   "/etc/tlp.d/50-platform-profile.conf"
 	   (plain-file "50-platform-profile.conf"
 	               "PLATFORM_PROFILE_ON_AC=performance\nPLATFORM_PROFILE_ON_BAT=low-power\nCPU_HWP_DYN_BOOST_ON_AC=1\nCPU_HWP_DYN_BOOST_ON_BAT=0\n"))
 	  (service thermald-service-type)
 	  (service postgresql-service-type
 	           (postgresql-configuration
 	            (postgresql postgresql)))
 	  (service bluetooth-service-type
 	           (bluetooth-configuration
 	            (auto-enable? #t)))
 	  (service screen-locker-service-type
 	  	 (screen-locker-configuration
 	  	  (name "swaylock")
 	  	  (program (file-append swaylock "/bin/swaylock"))))
 	  (service libvirt-service-type)
 	  (service virtlog-service-type)
 	  (simple-service 'dbus-fwupd dbus-root-service-type 
 	                  (list fwupd-nonfree))
 	  (simple-service 'polkit-fwupd polkit-service-type 
 	                  (list fwupd-nonfree))
 	  (service iptables-service-type)
 	  
 	  (service rootless-podman-service-type
 	           (rootless-podman-configuration
 	            (subuids (list (subid-range (name "light"))))
 	            (subgids (list (subid-range (name "light"))))))
 	  
 	  (service containerd-service-type)
 	  (service docker-service-type)
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
 	 			"https://guix.bordeaux.inria.fr"
 	 			"https://substitutes.nonguix.org"
 	 			)
 	 		       %default-substitute-urls
 	 
 	 		       ))
 	 		     (authorized-keys
 	 		      (append
 	 		       (list (local-file "./signing-key.pub")
 	 			     (local-file "./guix-sci-key.pub"))
 	 		       %default-authorized-guix-keys)))))
 	 
 	 ))
 
 (name-service-switch %mdns-host-lookup-nss))
