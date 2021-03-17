;;; ../dotfiles/.doom.d/emacs-yaml-tools/eyt-convert-to-ut.el -*- lexical-binding: t; -*-

(defun eyt-convert-to-ut ()
  (interactive)
  (let* ((line (fetch-current-line))
         (value (extract-yaml-value line))
         (path (form-path-with-dot (fetch-yaml-path))))
    (kill-new (concat "\s\s\s\s\s\s- equal:\n" "\s\s\s\s\s\s\s\s\s\spath: " path "\n\s\s\s\s\s\s\s\s\s\svalue: " value))
    (message (concat "path:" path "  value:" value))))
