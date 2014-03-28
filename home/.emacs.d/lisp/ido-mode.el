; Turn on
(ido-mode 1)

; Show entries in minibuffer
(require 'ido-vertical-mode)
(ido-vertical-mode)

; Keys
(add-hook 'ido-setup-hook (lambda ()
  ; Redefines <SPACE> to insert a space in ido mode
  ;   The ido-complete-space docstring:
  ;     "Try completion unless inserting the space makes sense"
  ;   Apparently, opening a new file with a space in it does not make sense,
  ;   hence this hackish remapping
  (define-key ido-completion-map " "
    (lambda ()
      (interactive)
      (insert " ")))
  ))

(setq
  ; Create new buffers when necessary
  ido-create-new-buffer 'always
  ido-enable-prefix     t
  )
