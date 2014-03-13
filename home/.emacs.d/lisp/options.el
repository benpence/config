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
