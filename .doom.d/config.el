;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Qiyan Zhang"
      user-mail-address "qiyan@hey.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org-files/")
(setq org-roam-directory "~/org-files/roam")

(custom-set-variables
 '(org-agenda-files (list org-directory)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(load! "my-func.el")
(load! "yaml-path.el")


(setq org-hide-emphasis-markers t)

(use-package! cnfonts
  :config
  (cnfonts-enable)
  (setq cnfonts-use-face-font-rescale t)
  )

(use-package! org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8081
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))


(setq org-capture-templates
      '(("j" "Journal" entry
         (file+datetree "~/org-files/journal.org")
         "* %U %?\n %i\n%a")
        ("w" "Journal-webpage" entry
         (file+datetree "~/org-files/journal.org")
         "* %U [[%x][%?] \n")
        ("l" "life related tasks" entry
         (file+headline "~/org-files/agenda.org" "Life")
         "** TODO %^{todo_content}\n   SCHEDULED: %^t\n")
        ("t" "work and study tasks" entry
         (file+headline "~/org-files/agenda.org" "Work & Study")
         "** TODO %^{todo_content}\n   SCHEDULED: %^t\n")
        ("r" "refiled tasks" entry
         (file+headline "~/org-files/agenda.org" "Refiled")
         "** TODO %a \n  SCHEDULED: %^t\n")))

(setq org-extend-today-until 4)

(setq geiser-active-implementations '(racket))

(if (eq system-type 'darwin) ;; manually set the racket execution path for macos
    (setq racket-racket-program "/Applications/Racket/bin//racket"))


(defun calibre-open (path-to-media)
  (shell-command "open /Applications/calibre.app" ))
(org-add-link-type "calibre" 'calibre-open)
