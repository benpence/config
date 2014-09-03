(require 'dbulysse)

(setq
  inhibit-startup-message t         ; no startup message
  initial-scratch-message ""        ; empty scratch buffer
  )

; Bars
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

; Open links in tor
(dbulysse-add-keys '(
  ("C-c O" (lambda ()
    (interactive)
    (let
      ( (browse-url-browser-function 'browse-url-generic)
        (browse-url-generic-program  "~/bin/tor-browser")
        (browse-url-generic-args     '("-new-tab"))
        )
      (org-open-at-point))))))

(setq
  ; Never confirm new file/buffer")
  confirm-nonexistent-file-or-buffer nil

  ; Default browser
  browse-url-browser-function        'browse-url-chromium

  ; Bytes to hold for undo history
  undo-limit                         20000000
  undo-outer-limit                   20000000
  undo-strong-limit                  20000000

  require-final-newline              t
  )


; Toggle between narrowing and widening
; Original: github.com/mwfogleman/config/ /home/.emacs.d/michael.org#narrowing-and-widening
(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p))
          (widen))
        ((region-active-p)
          (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
          (org-narrow-to-subtree))
        ((derived-mode-p 'prog-mode)
          (narrow-to-defun))))
(dbulysse-add-keys '(("C-c n" narrow-or-widen-dwim)))

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
