(package-initialize)
(setq package-check-signature nil)
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
                company
                evil
                nlinum-relative
                yasnippet
                ox-hugo
                helm
                monokai-theme
                hungry-delete
                swiper
                counsel
                smartparens
                popwin
                evil-collection
                slime
                ) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-splash-screen 1)

(require 'nlinum-relative)
(nlinum-relative-setup-evil)                    ;; setup for evil
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(add-hook 'text-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
(setq nlinum-relative-redisplay-delay 0)      ;; delay
(setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...

(setq evil-want-keybinding nil)
(setq evil-want-C-i-jump nil) ;; use tab in normal mode while editing org file
(evil-mode 1)

(evil-collection-init)

(ivy-mode 1)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(defun open-init-file()
  (interactive)
  (find-file "~/dotfiles/config.org"))
(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "C-w") 'backward-kill-word)

(global-set-key (kbd "C-h") 'delete-backward-char)

(global-set-key "\C-s" 'swiper)

(global-set-key (kbd "M-x") 'counsel-M-x)

(global-set-key (kbd "C-c p f") 'counsel-git)

(with-eval-after-load 'ox
  (require 'ox-hugo))

(setq org-startup-indented t)

(global-company-mode t)

(require 'hungry-delete)
(global-hungry-delete-mode)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(require 'smartparens-config)
(smartparens-global-mode t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(global-auto-revert-mode t)

(require 'popwin)
(popwin-mode t)

(require 'dired-x)
(setq dired-dwin-target 1)

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("8em" "emacs")
					    ))

(setq inferior-lisp-program "/usr/bin/sbcl")
    (add-to-list 'load-path "/usr/local/bin/slime/")
    (require 'slime)
    (slime-setup)
(slime-setup '(slime-fancy))
