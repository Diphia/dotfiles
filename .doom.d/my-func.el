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
  "extract the link from a org-mode link like [[LINK][DESCRPTION]] or [[LINK]]"
  (interactive)
  (let ((selection (thing-at-point 'line t)))
    (when (string-match "\\[\\[\\(.*?\\)\\].*" selection) ;;non-greedy match
      (kill-new (match-string 1 selection)))))

(defun new-scratch-code ()
  "create an org-mode buffer for speciffic programming language as scratch"
  (interactive)
  (let ((code-extension (completing-read "Enter the language name: " '("emacs-lisp" "python" "scheme"))))
    (with-temp-buffer
      (find-file (format "~/temp/scratch.org" code-extension))
      (erase-buffer)
      (insert (format "#+begin_src %s\n#+end_src\n\n#+begin_src %s :results output\n#+end_src" code-extension code-extension)))))

