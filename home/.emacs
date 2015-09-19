; Add subdirectories to emacs's load-path for calls like (require 'module)
(let ((paths '(
  "~/.emacs.d/lisp/"
  "~/.emacs.d/elpa/"
  )))

  (mapc
    (lambda (path)
      (let ((default-directory path))
	(normal-top-level-add-subdirs-to-load-path)))
    paths))

(require 'dbulysse)

; Load my configs
; This makes it easier to add and temporarily remove 'modules'
(dbulysse-load-files "~/.emacs.d/lisp/" '(
  "packages.el"          ; Package repos

  "linum-mode.el"        ; Line numbers on the left
  "evil-mode.el"         ; vim emulation
  "ido-mode.el"          ; file/buffer finder replacement
  "org-mode.el"          ; org-mode tweaks

  "backup.el"            ; Backup optons
  "show-paren.el"        ; Matching parens options/keys

  "haskell-mode.el"      ; haskell editing tweaks
  "scala-mode.el"

  "misc.el"              ; simple editor tweaks
  ))
