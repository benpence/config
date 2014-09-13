; Customizations
(setq 
  ; cp, not mv, old version to backup location
  ;   -> hardlinks point to current file, not backup
  backup-by-copying      t
  ; Which files to backup and where
  backup-directory-alist '(
    ("." . "~/.emacs.d/backup")
    )
  ; Where to put modified, unsaved files
  auto-save-file-name-transforms '(
    (".*" "~/.emacs.d/backup/" t)
    )
  ; Delete old backups silently
  delete-old-versions    t
  ; Oldest backups to keep
  kept-old-versions      6
  ; Newest backups to keep
  kept-new-versions      12
  ; Create numbered backups
  version-control        t
  )
