(use-modules (guix profiles)         ; for packages->manifest
             (gnu packages emacs)
             (gnu packages emacs-xyz)
             (gnu packages guile-xyz) ; for some geiser-related libs
             (gnu packages pdf)
	     (gnu packages llvm)
             (gnu packages terminals)) ; for libvterm

(define my-emacs-package-list  (list emacs-pgtk
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
        ;; emacs-mkmcc-gnuplot-mode  ; Ensure this variable exists in your modules
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
        emacs-macrostep))

;; The "Clean" way:
(packages->manifest (append
		     (list clang-toolchain)
		     my-emacs-package-list
		     ))
