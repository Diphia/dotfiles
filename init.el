(require 'org-install)
(require 'ob-tangle)

(setq dotfiles-dir "~/dotfiles")
(org-babel-load-file (expand-file-name "config.org" dotfiles-dir))
