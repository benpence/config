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
