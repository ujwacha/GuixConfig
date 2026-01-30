(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells)
	     (gnu home services desktop)
	     (gnu home services sway)
	     (gnu home services)
	     (gnu services databases)
             (gnu home services shepherd)

	     (my services i3blocks)

	     (gnu packages databases)
	     (gnu packages video)
	     (gnu packages package-management)
	     (gnu packages bittorrent)
	     (gnu packages gnome)
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
	     (gnu packages fonts)
	     (nongnu packages emacs)
	     (nongnu packages fonts)
	     (nongnu packages mozilla)
	     (nongnu packages chrome)
	     (nonguix multiarch-container))



(define my-configlist
  '(
    (NETWORK
     (command . "~/.scripts/which-net.sh")
     (interval . 2))
    
    (DISK
     (command . "df -h / | awk '/\\//{ printf(\" 💾 %4s/%s \\n\", $4, $2) }'")
     (interval . 10)
     (color . (201 227 219))) ; #C9E3DB

    (BATTERY
     (command . "~/.scripts/battery-percentage.sh")
     (interval . 3))

    ;; (CPU
    ;;  (full_text . " CPU:  0.00% @ +00.0°C ")
    ;;  (command . "~/.config/i3blocks/cpu/cpu_info.sh")
    ;;  (interval . repeat)
    ;;  (color . (0 180 235))) ; #00B4EB

    (MEM
     (command . "free -h | awk '/Mem:/ { printf(\" 🐏 %5s/%s \\n\", $3, $2) }'")
     (interval . 1)
     (color . (254 201 37))) ; #FEC925


    ;; (SOUND
    ;;  (full_text . " 🔇:  0% ")
    ;;  (command . "~/.config/i3blocks/sound/sound_info.sh")
    ;;  (interval . 0)
    ;;  (signal . 1))
 
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
	emacs-pdf-tools
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
	emacs-macrostep-geiser
	))


(define compiler-toolchain
  (list  pkg-config
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

(define fun-programs
  (list htop
	vlc
	flatpak
;;	flatpak-kcm
	transmission
	transmission-remote-gtk
	rtorrent
	neofetch
	gnome-tweaks
	vim
	fzf
	firefox-esr
	google-chrome-stable
	octave
	bc
	acpi
	xdg-user-dirs
	netcat
	gnome-shell-extensions
	gnuplot
	foot
	kitty
	keepassxc
	nwg-launchers
	))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages
  (append
   sql-packages-list
   (list texlive-scheme-full)
   my-emacs-package-list
   useful-fonts
   compiler-toolchain
   fun-programs
   ;; (specifications->packages (list
   ;; 			      "xdg-user-dir"))
   ))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (append (list 
	   (service home-bash-service-type
		    (home-bash-configuration
		     (bash-profile (list (local-file ".//.bash_profile"
                                                     "bash_profile")
					 (plain-file "flatpak-path-fix"
						     "source ~/.guix-home/profile/etc/profile.d/flatpak.sh")))
		     
		     (aliases '(("ls" . "ls --color=auto")
				("grep" . "grep --color=auto")
				("ll" . "ls -alF")))
		     
		     (bashrc (list (plain-file "bashrc-custom"
					       "export PS1='\\[\\e[0m\\]┌─\\[\\e[01;34m\\][\\u@\\h]\\[\\e[00m\\] - \\[\\e[01;33m\\][\\w]\\[\\e[00m\\] - \\[\\e[01;32m\\][\\!]\\[\\e[00m\\]\\n└─\\[\\e[01;31m\\][\\$]\\[\\e[00m\\] '")

				   (plain-file "bashrc-fzf-part"
					       " eval \"$(fzf --bash)\"")))))



	   (service home-files-service-type
		    (list `(".inputrc"
			    ,(plain-file "inputrc"
					 "
\"\\t\": menu-complete
\"\\e[Z\": menu-complete-backward
set colored-stats on
set menu-complete-display-prefix on

\"\\e[A\": history-search-backward
\"\\e[B\": history-search-forward
"))
			  `(".config/autostart/myscript.desktop"
			    ,(plain-file "myscript.desktop"
					 "[Desktop Entry]\nType=Application\nName=My Startup Script\nExec=\"bash /home/light/.qolscripts/emacs-daemon.sh\"\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\n"))))


	   (simple-service 'my-environment-variables
			   home-environment-variables-service-type
			   `(("PATH" . ,(string-append (getenv "HOME") "/.local/bin:"
                                                       "$PATH"))
			     ("PICO_SDK_PATH" . ,(string-append (getenv "HOME") "/Desktop/dev_ws/src/pico-sdk/"))
			     ;;("QT_QPA_PLATFORM" . "xcb")
			     ("MOZ_ENABLE_WAYLAND" . "1")
			     ;;("_JAVA_AWT_WM_NONREPARENTING" . "1")
			     ))

	   (service home-i3blocks-service-type my-configlist)

	   (service home-sway-service-type)
	   
	   (service home-dbus-service-type))
          %base-home-services)))
