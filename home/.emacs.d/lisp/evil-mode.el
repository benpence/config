(require 'evil-org)

(defun evil-undefine ()
 "Leave some bindings alone.
When used in conjunction with `define-key', it calls the original binding.
Credit: http://dnquark.com/blog/2012/02/emacs-evil-ecumenicalism/"
  (interactive)
  (let (evil-mode-map-alist)
    (call-interactively (key-binding (this-command-keys)))))

(setcdr evil-insert-state-map nil) ; clears insert state bindigs so insert state 
(define-key evil-insert-state-map  ; is basically emacs state
  (read-kbd-macro evil-toggle-key)
  'evil-emacs-state)

(define-key evil-insert-state-map  ; set C-z to switch from insert state back to
  "\C-z"                           ; normal state
  'evil-normal-state)

(define-key evil-normal-state-map  ; ignore tab in normal state
  (kbd "TAB")
  'evil-undefine)

(evil-mode 1)
