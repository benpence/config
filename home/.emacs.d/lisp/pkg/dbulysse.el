(require 'cl) ; For lexical-let

(defun dbulysse-add-keys (keypairs &optional modehook)
  "Add a list of (\"C-a\" (lambda () (interactive))) like hotkey tuples.
Optional modehook for mode-specific"
  ; Preserve keys for add-hook function
  (lexical-let
    (  
      ; Convert the "M-x" (etc.) strings to emacs key data
      (keys (mapcar
        (lambda (keypair)
          (list (kbd (car keypair)) (cadr keypair)))
        keypairs))
    )
      
    ; Mode-specific or global hotkey?
    (if modehook
        ; TODO: More efficient to use instead:
        ;   (eval-after-load MODE '(define-key MODE-map KEY FUNCTION))
        ; Mode keys
        (add-hook
          modehook
          (lambda () (mapc
            (lambda (key)
              (local-set-key (car key) (cadr key)))
            keys)))

        ; Global keys
        (mapc
          (lambda (key)
            (global-set-key (car key) (cadr key)))
          keys))))

(defun dbulysse-load-files (prefix files)
  "Load list of files all with prefix"
  (mapcar
    (lambda (file)
      (load-file (expand-file-name file prefix)))
    files))

(defun dbulysse-org-todo-columns ()
  "Show TODO items in org column view"
  (interactive)

  ; Already showing this information?
  ; TODO find better columns view detection
  (if (and (boundp 'org-columns-begin-marker)
           (eql
             (marker-buffer org-columns-begin-marker)
             (current-buffer)))
      ; Clear columns and highlights
      (progn
        (org-columns-quit)
        (org-remove-occur-highlights)
        (org-content))
      ; Show columns (file-wide) and highlights
      (save-excursion
        (org-show-todo-tree nil)
        ;(org-sparse-tree)
        ; TODO insert newline and then remove it
        (beginning-of-buffer)
        (insert "\n")
        ; TODO use (window-width) to truncate ITEM formatter
        (org-columns (concat
          "%28ITEM %TODO %SCHEDULED %TAGS"))
        (delete-char 1)
      )))

(defun dbulysse-org-truncate-category (max-width ellipses seperator)
  "A string formatter that truncates the org category to length `max-width', uses `ellipses' to show truncation, and appends `seperator' at the end.

The expression

(let ((category \"primary\"  )) (org-agenda-truncate-category 8 \"...\" \":\")
(let ((category \"secondary\")) (org-agenda-truncate-category 8 \"...\" \":\")

will yield

\"primary :\"
\"secon...:\""
  (let*
    ( (truncated-width
        (min
          (length category)
          max-width))
      (untruncated-width
        (-
          max-width
          truncated-width))
      )

    ; Truncate category?
    (if (< max-width (length category))
        (format
          "%s%s%s"
          ; Category without last _ characters
          (substring
            category
            0
            (-
              max-width
              (length ellipses)))
          ellipses
          seperator)
        (format
          "%s%s%s"
          (substring
            category
            0
            truncated-width)
          ; Space padding
          (make-string
            untruncated-width
            ? )
          seperator))))

(defun dbulysse-org-projects ()
  (interactive)

  (let*
    ( (org-agenda-files         '("~/Documents/me/agenda/Projects.org"))
      (org-agenda-prefix-format "  ")
      )
    (org-todo-list)))

(provide 'dbulysse)
