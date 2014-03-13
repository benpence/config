(setq inhibit-startup-message t)    ; no startup message
(setq-default indent-tabs-mode nil) ; disable tabs

; Backup
(setq
 backup-by-copying      t 
 backup-directory-alist '(("." . "~/.emacs.d/backup"))
 delete-old-versions    t
 kept-new-versions      6
 kept-old-versions      2
 version-control        t
 )

; ido mode
(ido-mode 1)
(require 'ido-vertical-mode)
(ido-vertical-mode)
