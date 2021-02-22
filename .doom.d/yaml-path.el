;;; ../dotfiles/.doom.d/yaml_path.el -*- lexical-binding: t; -*-

(defun jpt-yaml-indentation-level (s)
  (if (string-match "^ " s)
      (+ 1 (jpt-yaml-indentation-level (substring s 1)))
    0))

(defun jpt-yaml-current-line ()
  (buffer-substring-no-properties (point-at-bol) (point-at-eol)))

(defun jpt-yaml-clean-string (s)
  (let* ((s (replace-regexp-in-string "^[ -:]*" "" s))
         (s (replace-regexp-in-string ":$" "" s)))
    s))

(defun jpt-yaml-not-blank-p (s)
  (string-match "[^[:blank:]]" s))

(defun jpt-yaml-not-execute (s)
  (not (string-match "^{{.*}}$" s)))

(defun jpt-yaml-not-inside-array (s)
  (not (string-match "^\s*-.*" s)))

(defun jpt-yaml-path-to-point ()
  (save-excursion
    (let* ((line (jpt-yaml-current-line))
           (level (jpt-yaml-indentation-level line))
           result)
      (while (> (point) (point-min))
        (beginning-of-line 0)
        (setq line (jpt-yaml-current-line))
        (let ((new-level (jpt-yaml-indentation-level line)))
          (when (and (jpt-yaml-not-blank-p line)
                     (jpt-yaml-not-execute line)
                     (jpt-yaml-not-inside-array line)
                     (< new-level level))
            (setq level new-level)
            (setq result (push (jpt-yaml-clean-string line) result)))))
      result)))
      ;;(mapconcat 'identity result " => "))))

(defun yaml-get-path ()
  (interactive)
  (let ((result (jpt-yaml-path-to-point)))
    (message (mapconcat 'identity result " => "))
    (kill-new (mapconcat 'identity result "."))))

;;(defun jpt-yaml-show-path-to-point ()
  ;;(interactive)
  ;;(let ((output (jpt-yaml-path-to-point)))
    ;;(message (jpt-yaml-path-to-point)))
    ;;(message output)
    ;;(kill-new output)))

;;(eval-after-load 'yaml-mode
  ;;'(progn
     ;;(define-key yaml-mode-map (kbd "C-x p") 'jpt-yaml-show-path-to-point)))
