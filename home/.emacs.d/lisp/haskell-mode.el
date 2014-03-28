(require 'haskell-mode-autoloads)
(require 'dbulysse)

; Haskell mode indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

; Keys
(dbulysse-add-keys '(
   ("C-c c" haskell-compile)
   )
  'haskell-mode-hook)
