(require 'package)

; Add repos
(let ((repos '(
  ("melpa" . "http://melpa.milkbox.net/packages/")
  ("org"   . "http://orgmode.org/elpa/")
  )))
 
  (mapc
    (lambda (repo)
      (add-to-list 'package-archives repo t))
    repos))
