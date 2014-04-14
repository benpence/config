(require 'haskell-mode-autoloads)
(require 'dbulysse)

; Haskell mode indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

; Keys
(dbulysse-add-keys '(
   ("C-c c" haskell-compile)
   )
  'haskell-mode-hook)

; Options
(setq
  ; No warning when tabbing between autotab suggestions
  haskell-indentation-cycle-warn nil
  ; 4 tabs indents
  haskell-indentation-left-offset 4
  haskell-indentation-layout-offset 4
  )
