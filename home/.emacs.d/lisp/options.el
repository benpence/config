(setq inhibit-startup-message t)    ; no startup message
(setq-default indent-tabs-mode nil) ; disable tabs

; Backup
(setq
 version-control        t
 )

; ido mode
(ido-mode 1)
(require 'ido-vertical-mode)
(ido-vertical-mode)

; Replace yes/no functions with y/n
(fset 'yes-or-no-p 'y-or-n-p)

; Confirm kill buffer only on modified buffers
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

; Haskell mode indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
