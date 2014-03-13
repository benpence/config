(require 'cl) ; For lexical-let

(defun my-add-keys (keypairs &optional modehook)
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

; Global keys
(my-add-keys '(
  ; Reload init file
  ("C-c r" (lambda ()
    (interactive)
    (load-file "~/.emacs")))

  ; Alternate point between matching parens
  ("C-c C-c" (lambda (arg)
    (interactive "p")
    (cond ((looking-at   "\\s\(") (forward-list 1))
          ((looking-back "\\s\)") (backward-list 1)))))

  ; TODO: override keys properly
  ; Duplicate M-< M-> as C-, C-. respectively
  ;("C-," 'beginning-of-buffer)
  ;("C-." 'end-of-buffer)

  ; With selection -> M-w
  ; No selection   -> M-w whole buffer
  ("C-c w" (lambda ()
    (interactive)
    (if mark-active
        (copy-region-as-kill)
        (copy-region-as-kill (point-min) (point-max)))))
  ))

; Org mode
(my-add-keys '(
    ; TODO: How to quote here?
    ("C-c a" (lambda () (interactive) (org-agenda)))
    ("C-c c" (lambda () (interactive) (org-capture)))
    )
  'org-mode-hook)
