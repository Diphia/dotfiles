;;; ../dotfiles/.doom.d/emacs-yaml-tools/eyt-get-value.el -*- lexical-binding: t; -*-

;; get the path of values files from the header of UT block
(defun extract-values-file-for-ut ()
  (save-excursion
    (let* ((line (fetch-current-line))
           (level (fetch-yaml-indentation-level line))
           (values-file-path)
           (exitflag))
      (while (and (> (point) (point-min)) (not exitflag))
        (beginning-of-line 0)
        (setq line (fetch-current-line))
        (setq level (fetch-yaml-indentation-level line))
        (cond ((and (string-match "^\s*values" (extract-yaml-key line)) (= level 4))
               (setq values-file-path (replace-regexp-in-string "-\s./" "" (extract-yaml-value line)))
               (setq exitflag t))))
      (concat
       (replace-regexp-in-string (replace-regexp-in-string "<.*>" "" (buffer-name)) "" (buffer-file-name))
       (replace-regexp-in-string "\s" "" values-file-path)))))

(defun extract-values-file ()
  (cond ((string-match ".*_test.yaml$" (replace-regexp-in-string "<.*>" "" (buffer-name)))
         (extract-values-file-for-ut))
        (t (let ((s (buffer-file-name)))
             (when (string-match "\\(.*/\\)templates.*" s)
               (concat (match-string 1 s) "values.yaml"))))))

(defun extract-value-path ()
  (let ((line (fetch-current-line)))
    (when (string-match "\\(.Values[.a-z0-9_]*\\)" line)
      (strip-string (replace-regexp-in-string "\s*\t*.Values\\." "" (match-string 1 line))))))

(defun read-value-from-yaml (fpath vpath)
  (with-temp-buffer
    (insert-file-contents fpath)
    (let* ((line (fetch-current-line))
           (level (fetch-yaml-indentation-level line))
           (target-level 0)
           (result)
           (vpath (split-string (strip-string vpath) "\\."))
           (exitflag))
      (while (and (< (point) (point-max)) (not exitflag))
        (setq line (fetch-current-line))
        (setq current-level (fetch-yaml-indentation-level line))
        (cond ((and (= current-level target-level)
                    (string-match (car vpath) (extract-yaml-key line))
                    (not (string-match "\s*#" (extract-yaml-key line))))
               (cond ((eq (cdr vpath) '())
                      (setq result (strip-string (extract-yaml-value line)))
                      (setq exitflag t))
                     (t
                      (setq vpath (cdr vpath))
                     (setq target-level (+ target-level 2))))))
        (beginning-of-line 2))


(defun eyt-get-value ()
  (interactive)
  (let ((result (read-value-from-yaml (extract-values-file) (extract-value-path)))
        (line (fetch-current-line)))
    (message result)
    (kill-new (replace-regexp-in-string "{{.*}}" result line))))
