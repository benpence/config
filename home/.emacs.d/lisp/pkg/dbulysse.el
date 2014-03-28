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

(provide 'dbulysse)
