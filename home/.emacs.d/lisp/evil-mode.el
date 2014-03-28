(require 'evil)
(evil-mode 1)

(setcdr evil-insert-state-map nil) ; clears insert state bindigs so insert state 
(define-key evil-insert-state-map  ; is basically emacs state
  (read-kbd-macro evil-toggle-key)
  'evil-emacs-state)

(define-key evil-insert-state-map  ; set C-z to switch from insert state back to
  "\C-z"                           ; normal state
  'evil-normal-state)
