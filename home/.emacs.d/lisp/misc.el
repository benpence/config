(require 'dbulysse)

; Bars
(setq inhibit-startup-message t)    ; no startup message
(setq-default indent-tabs-mode nil) ; disable tabs

(menu-bar-mode 0)                   ; disable menubar on frames
(column-number-mode t)              ; show column in mode line

; Color Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/color")
(setq custom-safe-themes t)
(load-theme 'oak)

; Replace yes/no functions with y/n
(fset 'yes-or-no-p 'y-or-n-p)

; Confirm kill buffer only on modified buffers
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

(setq
  ; Never confirm new file/buffer")
  confirm-nonexistent-file-or-buffer nil

  ; Bytes to hold for undo history
  undo-limit                         20000000
  undo-outer-limit                   20000000
  undo-strong-limit                  20000000
  )

; Global keys
(dbulysse-add-keys '(
  ; Reload init file
  ("C-c r" (lambda ()
    (interactive)
    (load-file "~/.emacs")))

  ("C-c C-j" (lambda (begin end)
    (interactive "r")
    (let
      ; TODO: 
      ((fill-column 10000000))
      (fill-paragraph nil '(begin end)))))
  ))
