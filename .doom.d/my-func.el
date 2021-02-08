;;; ../dotfiles/.doom.d/my-func.el -*- lexical-binding: t; -*-

(defun get-current-heading-link ()
  "get the current heading link"
  (let ((current-heading (org-get-heading))
        (current-filename (abbreviate-file-name buffer-file-name)))
    (format "[[%s::*%s][%s]]"
            current-filename
            current-heading
            current-heading)))

(defun yank-current-heading-link ()
  "get the current heading link, add to the killring"
  (interactive)
  (kill-new (get-current-heading-link)))


(defun extract-org-mode-link ()
  "extract the link from a org-mode link like [[LINK][DESCRPTION]]"
  (interactive)
  (insert (org-element-context))
  )
