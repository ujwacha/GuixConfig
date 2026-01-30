(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells)
	     (gnu home services desktop)
	     (gnu home services sway)
	     (gnu home services pm)
	     (gnu home services sound)
	     (gnu home services)
	     (gnu services databases)
             (gnu home services shepherd)
	     
	     (my services i3blocks)
	     (gnu packages wm)
	     (gnu packages databases)
	     (gnu packages pulseaudio)
	     (gnu packages video)
	     (gnu packages package-management)
	     (gnu packages bittorrent)
	     (gnu packages gnome)
	     (gnu packages gnome-xyz)
	     (gnu packages xorg)
	     (gnu packages vim)
	     (gnu packages terminals)
	     (gnu packages maths)
	     (gnu packages algebra)
	     (gnu packages linux)
	     (gnu packages freedesktop)
	     (gnu packages password-utils)
	     (gnu packages pkg-config)
	     (gnu packages autotools) 
	     (gnu packages build-tools)
	     (gnu packages cmake)
	     (gnu packages base)
	     (gnu packages commencement)
	     (gnu packages llvm)
	     (gnu packages python)
	     (gnu packages python-xyz)
	     (gnu packages rust)
	     (gnu packages xdisorg)
	     (gnu packages admin)
	     (gnu packages java)
	     (gnu packages sqlite)
	     (gnu packages python-science)
	     (gnu packages duckdb)
	     (gnu packages web)
	     (gnu packages tex)
	     (gnu packages emacs)
	     (gnu packages emacs-xyz)
	     (gnu packages fonts)
	     (gnu system keyboard)      ;; Required for keyboard-layout
	     (gnu packages xdisorg)    ;; For swaylock, wl-clipboard
	     (nongnu packages emacs)
	     (nongnu packages fonts)
	     (nongnu packages mozilla)
	     (nongnu packages chrome)
	     (nonguix multiarch-container))

(define my-i3blocks-configlist
  '(
    (NETWORK
     (command . "~/.scripts/which-net.sh")
     (interval . 2))
    
    (DISK
     (command . "df -h / | awk '/\\//{ printf(\" 💾 %4s/%s \\n\", $4, $2) }'")
     (interval . 10)
     (color . (201 227 219)))
    
    (BATTERY
     (command . "~/.scripts/battery-percentage.sh")
     (interval . 3))

    (CPU
     (command . "~/.scripts/cpu-freq-percentage.sh")
     (interval . 1)
     (color . (0 255 128)))
    
    (MEM
     (command . "free -h | awk '/Mem:/ { printf(\" 🐏 %5s/%s \\n\", $3, $2) }'")
     (interval . 1)
     (color . (254 201 37)))
    
    (SOUND
     (command . "~/.config/i3blocks/sound/sound_info.sh")
     (interval . 5)
     (signal . 10))

    (TIME_DATE
     (command . "date +\" %a, %d %b - %H:%M:%S\"")
     (interval . 1))))

(define sql-packages-list
  (list sqlite
	postgresql
	mariadb
	sqlitebrowser
	pgloader
	python-psycopg2
	python-sqlalchemy
	python-pandas
	duckdb
	redis
	jq))

(define my-emacs-package-list
  (list emacs-pgtk
	emacs-use-package
	emacs-forge
	emacs-pdf-tools
	emacs-htmlize
	emacs-lsp-mode
	emacs-lsp-ui
	emacs-lsp-ivy
	emacs-lsp-treemacs
	emacs-guix
	emacs-gcmh
	emacs-ivy
	emacs-swiper
	emacs-php-mode
	emacs-doom-modeline
	emacs-all-the-icons
	emacs-spacemacs-theme
	emacs-doom-themes
	emacs-rainbow-delimiters 
	emacs-which-key
	emacs-ivy-rich
	emacs-counsel
	emacs-undo-tree
	emacs-company
	emacs-yasnippet
	emacs-vterm
	emacs-beacon
	emacs-neotree
	emacs-helpful
	emacs-markdown-mode
	emacs-simple-httpd
	emacs-elfeed
	emacs-projectile
	emacs-web-mode
	emacs-typescript-mode
	emacs-flycheck
	emacs-magit
	emacs-mkmcc-gnuplot-mode
	emacs-gnuplot
	emacs-rainbow-mode
	emacs-all-the-icons-dired
	emacs-emms
	emacs-dirvish
	emacs-drag-stuff
	emacs-multiple-cursors
	emacs-expand-region
	emacs-golden-ratio
	emacs-pyvenv
	emacs-mentor
	emacs-auctex
	emacs-org
	emacs-org-bullets
	emacs-org-roam
	emacs-org-roam-ui
	emacs-gptel
	emacs-dashboard
	emacs-visual-fill-column
	emacs-org-pdftools
	emacs-ox-reveal
	emacs-org-download
	emacs-org-fragtog
	emacs-flycheck-rust
	emacs-rustic
	emacs-counsel-projectile
	emacs-request
	emacs-djvu
	emacs-nov-el
	emacs-geiser
	emacs-geiser-guile
	emacs-paredit
	emacs-macrostep
	emacs-macrostep-geiser))

(define useful-fonts
  (list font-hack
        font-google-roboto
        font-google-noto
        font-dejavu
        font-liberation
        font-microsoft-web-core-fonts
        font-microsoft-webdings
        font-wqy-zenhei
        font-wqy-microhei
        font-google-noto-emoji
        font-adobe-source-han-serif
        font-adobe-source-han-sans
        font-gnu-freefont
        font-awesome
        font-cica))

(define compiler-toolchain
  (list pkg-config
	libtool
	autoconf
	automake
	cmake
	gcc-toolchain
	clang-toolchain
	python
	python-lsp-server
	rust
	rust-analyzer))

(define fun-programs
  (list htop
	vlc
	flatpak
	transmission
	transmission-remote-gtk
	rtorrent
	neofetch
	gnome-tweaks
	vim
	fzf
	firefox-esr
	google-chrome-stable
	thinkfan
	octave
	bc
	acpi
	xdg-user-dirs
	netcat
	gnome-shell-extensions
	pavucontrol
	pamixer
	alsa-utils
	libnotify
	gnuplot
	foot
	kitty
	keepassxc
	bibata-cursor-theme
	xcursor-themes
	nwg-launchers))

(define unity-orange
  (sway-border-color (border "#DD4814") (background "#DD4814") (text "#FFFFFF")))

(define unity-dark
  (sway-border-color (border "#2C2C2C") (background "#2C2C2C") (text "#AFAFAF")))

(define unity-neutral
  (sway-border-color (border "#3E3E3E") (background "#3E3E3E") (text "#DCDCDC")))

(define unity-urgent
  (sway-border-color (border "#DF382C") (background "#DF382C") (text "#FFFFFF")))

(home-environment
 (packages
  (append
   sql-packages-list
   (list texlive-scheme-full)
   my-emacs-package-list
   useful-fonts
   compiler-toolchain
   fun-programs
   ))

 (services
  (append (list
	   
	   (service home-bash-service-type
	   	 (home-bash-configuration
	   	  (bash-profile (list (local-file ".//.bash_profile" "bash_profile")
	   			      (plain-file "flatpak-path-fix"
	   					  "source ~/.guix-home/profile/etc/profile.d/flatpak.sh")))
	   	  (aliases '(("ls" . "ls --color=auto")
	   		     ("grep" . "grep --color=auto")
	   		     ("ll" . "ls -alF")
	   		     ("gcon" . "cd ~/.config/guix/")))
	   	  (bashrc (list (plain-file "bashrc-custom"
	   				    "export PS1='\\[\\e[0m\\]┌─\\[\\e[01;34m\\][\\u@\\h]\\[\\e[00m\\] - \\[\\e[01;33m\\][\\w]\\[\\e[00m\\] - \\[\\e[01;32m\\][\\!]\\[\\e[00m\\]\\n└─\\[\\e[01;31m\\][\\$]\\[\\e[00m\\] '")
	   			(plain-file "bashrc-fzf-part"
	   				    " eval \"$(fzf --bash)\"")))))
	   
	   (service home-files-service-type
	   	 (list `(".inputrc"
	   		 ,(plain-file "inputrc"
	   			      "\"\\t\": menu-complete\n\"\\e[Z\": menu-complete-backward\nset colored-stats on\nset menu-complete-display-prefix on\n\n\"\\e[A\": history-search-backward\n\"\\e[B\": history-search-forward\n"))
	   	       `(".config/autostart/myscript.desktop"
	   		 ,(plain-file "myscript.desktop"
	   			      "[Desktop Entry]\nType=Application\nName=My Startup Script\nExec=\"bash /home/light/.qolscripts/emacs-daemon.sh\"\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\n"))))
	   
	   (simple-service 'my-environment-variables
	   		home-environment-variables-service-type
	   		`(("PATH" . ,(string-append (getenv "HOME") "/.local/bin:" "$PATH"))
	   		  ("PICO_SDK_PATH" . ,(string-append (getenv "HOME") "/Desktop/dev_ws/src/pico-sdk/"))
	   		  ("MOZ_ENABLE_WAYLAND" . "1")
	   		  ("XCURSOR_THEME" . "Bibata-Original-Classic")
	   		  ("XCURSOR_SIZE" . "22")
	   		  ))
	   
	   
	   (simple-service 'bibata-manual-config
	                   home-xdg-configuration-files-service-type
	                   `(("gtk-3.0/settings.ini"
	                      ,(plain-file "settings.ini"
	                                   "[Settings]\ngtk-cursor-theme-name=Bibata-Modern-Ice\ngtk-cursor-theme-size=24"))
	                     ("gtk-4.0/settings.ini"
	                      ,(plain-file "settings.ini"
	                                   "[Settings]\ngtk-cursor-theme-name=Bibata-Modern-Ice\ngtk-cursor-theme-size=24"))))
	   
	   (service home-i3blocks-service-type my-i3blocks-configlist)
	   
	   ;; (use-modules (gnu home services sway)
	   ;; 	     (gnu packages xdisorg))
	   
	   
	   (service home-sway-service-type
	   	 (sway-configuration
	   	   (variables (append '((alt . "Mod1"))
	   	   		   %sway-default-variables))
	   	   (packages
	   	    (append (list swaylock
	   	   	       wl-clipboard
	   	   	       i3blocks)
	   	   	 %sway-default-packages))
	   	   (inputs
	   	    (list 
	   	     (sway-input (identifier "2:7:SynPS/2_Synaptics_TouchPad")
	   	   	      (disable-while-typing #t)
	   	   	      (disable-while-trackpointing #t)
	   	   	      (tap #t)
	   	   	      (extra-content '("natural_scroll enabled"
	   	   			       "middle_emulation enabled"
	   	   			       "pointer_accel 0.5"
	   	   			       "scroll_factor 2.0")))
	   	     
	   	     (sway-input (identifier "2:10:TPPS/2_Elan_TrackPoint")
	   	   	      (extra-content '("pointer_accel 1.0")))
	   	   
	   	     (sway-input (identifier "type:keyboard")
	   	   	      (layout
	   	   	       (keyboard-layout "us" #:options '("ctrl:swapcaps")))
	   	   	      (extra-content '("repeat_rate 70")))))
	   	   
	   	   
	   	   (outputs
	   	    (list (sway-output
	   	           (identifier '*)
	   	           (background "~/.config/sway/wall"))
	   	          (sway-output
	   	   	 (identifier "eDP-1")
	   	   	 (position (point (x 0)
	   	   			  (y 0)))
	   	   	 (resolution "1920x1080"))))
	   	   (gestures  '((swipe:3:left . "workspace next_on_output")
	   	   	     (swipe:3:right    "workspace prev_on_output" . ("exact"))
	   	   	     (swipe:3:down . "move to scratchpad")
	   	   	     (swipe:3:up   . "scratchpad show")))
	   	   (keybindings
	   	    `(($mod+shift+return . "exec emacsclient -c")
	   	      ($mod+g . "exec bash /home/light/.qolscripts/lsqol.sh")
	   	      ($mod+Shift+d . "exec /home/light/.qolscripts/emacs_dired.sh")
	   	      ($mod+Mod1+$left . "resize shrink width 50px")
	   	      ($mod+Mod1+$down . "resize grow height 50px")
	   	      ($mod+Mod1+$up . "resize shrink height 50px")
	   	      ($mod+Mod1+$right . "resize grow width 50px")
	   	      (Mod1+Tab . "exec /home/light/.qolscripts/switchwindow.s")
	   	      ($mod+u . "exec rofi -i -show drun -show-icons")
	   	      ($mod+semicolon . "workspace prev")
	   	      ($mod+slash . "exec /home/light/.scripts/sway_workspace_change.sh i")
	   	      ($mod+Next . "exec /home/light/.scripts/sway_workspace_change.sh i")
	   	      ($mod+apostrophe . "workspace next")
	   	      ($mod+period . "exec /home/light/.scripts/sway_workspace_change.sh d")
	   	      ($mod+Prior . "exec /home/light/.scripts/sway_workspace_change.sh d")
	   	      ($mod+Tab . "workspace back_and_forth")
	   	      ($mod+Shift+semicolon . "move container to workspace prev")
	   	      ($mod+Shift+slash . "exec /home/light/.scripts/sway_workspace_move.sh i")
	   	      ($mod+Shift+apostrophe . "move container to workspace next")
	   	      ($mod+Shift+period . "exec /home/light/.scripts/sway_workspace_move.sh d")
	   	      ($mod+Shift+Tab . "move container to workspace back_and_forth")
	   	      ($mod+f . "exec firefox")
	   	      ($mod+Return . "exec $term")
	   	      ($mod+Shift+q . "kill")
	   	      ($mod+d . "exec $menu")
	   	      ($mod+Shift+c . "reload")
	   	      ($mod+Shift+e
	   	       . ,#~(string-append
	   	             "exec " #$sway "/bin/swaynag -t warning -m \\\n    "
	   	             "'You pressed the exit shortcut.  Do you really want to exit sway?"
	   	             " This will end your Wayland session.' \\\n    "
	   	             "-B 'Yes, exit sway' \\\n    '"
	   	             #$sway "/bin/swaymsg exit'"))
	   	      ($mod+$left . "focus left")
	   	      ($mod+$down . "focus down")
	   	      ($mod+$up . "focus up")
	   	      ($mod+$right . "focus right")
	   	      ($mod+Left . "focus left")
	   	      ($mod+Down . "focus down")
	   	      ($mod+Up . "focus up")
	   	      ($mod+Right . "focus right")
	   	      ($mod+Shift+$left . "move left")
	   	      ($mod+Shift+$down . "move down")
	   	      ($mod+Shift+$up . "move up")
	   	      ($mod+Shift+$right . "move right")
	   	      ($mod+Shift+Left . "move left")
	   	      ($mod+Shift+Down . "move down")
	   	      ($mod+Shift+Up . "move up")
	   	      ($mod+Shift+Right . "move right")
	   	      ($mod+1 . "workspace number 1")
	   	      ($mod+2 . "workspace number 2")
	   	      ($mod+3 . "workspace number 3")
	   	      ($mod+4 . "workspace number 4")
	   	      ($mod+5 . "workspace number 5")
	   	      ($mod+6 . "workspace number 6")
	   	      ($mod+7 . "workspace number 7")
	   	      ($mod+8 . "workspace number 8")
	   	      ($mod+9 . "workspace number 9")
	   	      ($mod+0 . "workspace number 10")
	   	      ($mod+Shift+1 . "move container to workspace number 1")
	   	      ($mod+Shift+2 . "move container to workspace number 2")
	   	      ($mod+Shift+3 . "move container to workspace number 3")
	   	      ($mod+Shift+4 . "move container to workspace number 4")
	   	      ($mod+Shift+5 . "move container to workspace number 5")
	   	      ($mod+Shift+6 . "move container to workspace number 6")
	   	      ($mod+Shift+7 . "move container to workspace number 7")
	   	      ($mod+Shift+8 . "move container to workspace number 8")
	   	      ($mod+Shift+9 . "move container to workspace number 9")
	   	      ($mod+Shift+0 . "move container to workspace number 10")
	   	      ($mod+q . "splith")
	   	      ($mod+w . "splitv")
	   	      ($mod+s . "layout stacking")
	   	      ($mod+t . "layout tabbed")
	   	      ($mod+e . "layout toggle split")
	   	      ($mod+n . "fullscreen")
	   	      ($mod+Shift+space . "floating toggle")
	   	      ($mod+space . "focus mode_toggle")
	   	      ($mod+p . "focus parent")
	   	      ($mod+o . "focus child")
	   	      ($mod+Shift+minus . "move scratchpad")
	   	      ($mod+Mod1+return . "scratchpad show")
	   	      ($mod+r . "mode \"resize\"")
	   	      (XF86AudioRaiseVolume . "exec --no-startup-id bash ~/.scripts/volctrl i")
	   	      (XF86AudioLowerVolume . "exec --no-startup-id bash ~/.scripts/volctrl d")
	   	      (XF86AudioMute . "exec --no-startup-id bash ~/.scripts/volctrl p")
	   	      (XF86AudioMicMute . "exec --no-startup-id pactl set-source-mute 0 toggle")
	   	      (XF86MonBrightnessUp . "exec brightnessctl set 5%+")
	   	      (XF86MonBrightnessDown . "exec brightnessctl set 5%-")
	   	      )
	   	    )
	   	   (bar (sway-bar
	   	          (position 'top)
	   	          (hidden-state 'show)
	   	          (binding-mode-indicator #t)
	   	          (status-command "i3blocks")
	   	          (colors (sway-color
	   	                  (background "#2C2C2C")
	   	                  (statusline "#DCDCDC")
	   	                  (focused-workspace unity-orange)
	   	                  (active-workspace  unity-neutral)
	   	                  (inactive-workspace unity-dark)
	   	                  (urgent-workspace  unity-urgent)))))
	   	   (extra-content
	   	    (append
	   	     
	   	     `("default_border pixel 2"
	   	       "assign [class=\"qBittorrent\"] 9"
	   	       "assign [class=\"discord\"] 10"
	   	       "assign [class=\"steam\"] 9"
	   	       "for_window [app_id=\"imv\"] floating enable"
	   	       "for_window [class=\"ThinkFan UI\"] floating enable"
	   	       "for_window [class=\"XPaint\"] floating enable, move position 10px 10px"
	   	       "for_window [class=\"TopLevelShell\"] floating enable"
	   	       "for_window [title=\"^emacs-minibuffer$\"] floating enable, resize set 1200 600, border none"
	   	       "for_window [title=\"^emacs-minibuffer$\"] sticky enable"
	   	       "smart_borders on"
	   	       "smart_gaps on"
	   	       "seat seat0 xcursor_theme Bibata-Original-Classic 22"
	   	       )
	   	     
	   	     (let ((serialize (lambda (label rec)
	   	                        (format #f "client.~a ~a ~a ~a #2ECC71 ~a"
	   	                                label
	   	                                (sway-border-color-border rec)
	   	                                (sway-border-color-background rec)
	   	                                (sway-border-color-text rec)
	   	                                (sway-border-color-border rec)))))
	   	       (list
	   	        (serialize "focused"          unity-orange)
	   	        (serialize "focused_inactive" unity-neutral)
	   	        (serialize "unfocused"        unity-dark)
	   	        (serialize "urgent"           unity-urgent)
	   	        "client.background #2C2C2C"))))
	   	   (startup-programs 
	   	    (list
	   	     #~(string-append
	   	        #$swayidle "/bin/swayidle -w \\\n    "
	   	        ;; 300: lock screen.
	   	        "timeout 300 '" #$swaylock "/bin/swaylock "
	   	        "--indicator-radius 75 \\\n    "
	   	        "-i " #$sway
	   	        "/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png \\\n    "
	   	        "-f -c 000000' \\\n    "
	   	        ;; 600: lock + screen off.
	   	        "timeout 600 '" #$sway "/bin/swaymsg \"output * power off\"' \\\n    "
	   	        ;; 900: Sleep
	   	        ;;    "timeout 900 '" #$sway "/bin/swaymsg \"output * power off\"' \\\n    "
	   	        ;; "timeout 900 '" #$(file-append elogind "/bin/loginctl") " suspend' \\\n    "
	   	        "timeout 900 '/run/current-system/profile/bin/loginctl suspend' \\\n    "
	   	        ;; Resume + sleep.
	   	        "resume '" #$sway "/bin/swaymsg \"output * power on\"' \\\n    "
	   	        "before-sleep '" #$swaylock "/bin/swaylock -f -c 000000'")
	   	     
	   	     "~/.qolscripts/emacs-daemon.sh"
	   	     "mako"
	   	     ))
	   	   ))
	   
	   (service home-dbus-service-type)

	   (service home-batsignal-service-type
	           (home-batsignal-configuration
	             (danger-level 15)
	             (danger-command "loginctl poweroff")
	             (poll-delay 60)))

	   (service home-pipewire-service-type)
	   )
	  %base-home-services)))
