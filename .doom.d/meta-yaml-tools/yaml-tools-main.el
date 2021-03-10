(defun fetch-yaml-indentation-level (s)
  (cond ((or (string-match "^ " s) (string-match "^-" s))
         (+ 1 (fetch-yaml-indentation-level (substring s 1))))
        (t 0)))

(defun fetch-current-line ()
  (buffer-substring-no-properties (point-at-bol) (point-at-eol)))

(defun yaml-not-blank (s)
  (string-match "[^[:blank:]]" s))

(defun yaml-not-comment (s)
  (not (string-match "^\s*#" s)))

(defun yaml-inside-array (s)
  (and (string-match "^\s*-.*" s) (yaml-not-comment s)))

(defun yaml-not-execute (s)
  (not (string-match "^\s*\t*{{.*}}" s)))

(defun format-yaml-line (s)
  (let* ((s (replace-regexp-in-string "^[ -:]*" "" s))
         (s (replace-regexp-in-string ":$" "" s)))
    s))

(defun extract-yaml-key (s)
  (car (split-string s ":")))

(defun extract-yaml-value (s)
  (car (cdr (split-string s ":"))))

(defun fetch-yaml-path ()
  (save-excursion
    (let ((level (fetch-yaml-indentation-level (fetch-current-line)))
          (index -1)
          result)
      (if (yaml-inside-array (fetch-current-line)) (setq index (+ index 1)))
      (while (> (point) (point-min))
        (beginning-of-line 0)
        (setq line (fetch-current-line))
        (let ((new-level (fetch-yaml-indentation-level line)))
          (cond ((and (= new-level level)
                      (yaml-inside-array line)) (setq index (+ 1 index))))
          (cond ((and (< new-level level)
                      (yaml-not-blank line)
                      (yaml-not-comment line)
                      (yaml-not-execute line))
                 (save-excursion
                   (setq level new-level)
                   (cond ((= index -1)
                          (setq index_attach ""))
                         (t
                          (setq index_attach (concat "[" (number-to-string index) "]"))
                          (setq index -1)))
                   (setq result (push (concat (format-yaml-line line) index_attach) result)))))))
      result)))

(defun form-path-with-arrow (result)
  (concat (mapconcat 'identity result " => ")
          (concat " => " (extract-yaml-key (format-yaml-line (fetch-current-line))))))

(defun form-path-with-dot (result)
  (concat (mapconcat 'identity result ".")
          (concat "." (extract-yaml-key (format-yaml-line (fetch-current-line))))))

(defun yaml-get-path ()
  (interactive)
  (let ((result (fetch-yaml-path)))
    (message (form-path-with-arrow result))
    (kill-new (form-path-with-dot result))))

(defun convert-to-ut-case ()
  (interactive)
  (let* ((line (fetch-current-line))
         (value (extract-yaml-value line))
         (path (form-path-with-dot (fetch-yaml-path))))
    (kill-new (concat "- equal:\n" "path: " path "\nvalue: " value))
    (message (concat "path:" path "  value:" value))))
