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

; Global keys
(my-add-keys '(
  ; Reload init file
  ("C-c r" (lambda ()
    (interactive)
    (load-file "~/.emacs")))

  ; Alternate point between matching parens
  ("C-c C-c" (lambda (arg)
    (interactive "p")
          ; Match open paren
    (cond ((looking-at "\\s\(")
            (forward-list 1))
          ; Convenience for matching open paren after C-e
          ((and (looking-back "\\s\(")
                (looking-at "$"))
            (backward-char 1)
            (forward-list 1))
          ; Match close paren
          ((looking-back "\\s\)")
            (backward-list 1)))))

  ("C-c C-j" (lambda (begin end)
    (interactive "r")
    (let
      ; TODO:
      ((fill-column 10000000))
      (fill-paragraph nil '(begin end)))))

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
    ; Toggle between showing raw links and description
    ("C-c L" org-toggle-link-display)
    ))
(my-add-keys '(
    ("C-c a" org-agenda)  ; Agenda
    ("C-c c" org-capture) ; Create task from text
    ("C-c C" (lambda ()   ; Show TODO items in column view
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
          ))))
    )
  'org-mode-hook)

; haskell-mode
(my-add-keys '(
   ("C-c c" haskell-compile)
   )
  'haskell-mode-hook)

; ido-mode
(add-hook 'ido-setup-hook (lambda ()
  ; Redefines <SPACE> to insert a space in ido mode
  ;   The ido-complete-space docstring:
  ;     "Try completion unless inserting the space makes sense
  ;   Apparently, opening a new file with a space in it does not make sense,
  ;   hence this hackish remapping
  (define-key ido-completion-map " "
    (lambda ()
      (interactive)
      (insert " ")))
  ))
