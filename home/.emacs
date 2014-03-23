(defun my-load-config (prefix files)
  "Load list of files all with prefix"
  (mapcar
    (lambda (file)
      (load-file (expand-file-name file prefix)))
    files))

; Load my configs
; This makes it easier to add and temporarily remove 'modules'
(my-load-config "~/.emacs.d/lisp/" '(
  "global.el"
  "path.el"
  "packages.el"
  "options.el"
  "keys.el"
  "appearance.el"
  ))

;;; Settings handled by customize ;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying t nil nil "Always use copying to create backup files")
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backup"))) nil nil "Which files to backup and where")
 '(confirm-nonexistent-file-or-buffer nil nil nil "Never confirm new file/buffer")
 '(delete-old-versions t)
 '(dired-kept-versions 2 nil nil "Backups")
 '(global-linum-mode t nil nil "Line numbers on left for all modes")
 '(ido-create-new-buffer (quote always) nil nil "Create new buffers when necessary")
 '(ido-enable-prefix t)
 '(kept-new-versions 6)
 '(linum-format (quote linum-relative) nil nil "Add a space after line, between text")
 '(linum-relative-current-symbol "" nil nil "Show absolute line number for current line")
 '(linum-relative-format "%2s " nil nil "Ensures 2 digit width on relative line numbers. Adds space between numbers and text")
 '(org-agenda-files (quote ("~/Documents/me/")))
 '(org-footnote-auto-adjust t)
 '(org-log-done (quote time))
 '(org-startup-folded t nil nil "Start org mode showing everything")
 '(org-startup-indented t)
 '(show-paren-delay 0.1 nil nil "Showing matching parens is nearly instantaneous")
 '(show-paren-mode t nil nil "Show matching parentheses when pointer is on them")
 '(undo-limit 20000000 nil nil "Bytes to hold for undo history")
 '(undo-outer-limit 20000000)
 '(undo-strong-limit 20000000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#000" :foreground "color-227"))))
 '(linum-relative-current-face ((t (:inherit linum :background "color-54" :foreground "brightwhite"))) nil "Line numbers face")
 '(org-column ((t (:background "grey10" :strike-through nil :underline nil :slant normal :weight normal))) nil "Background for org column view")
)

; TODO: Research post loading hook
(linum-relative-toggle)
(linum-relative-toggle)
