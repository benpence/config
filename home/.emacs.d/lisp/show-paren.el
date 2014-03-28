(require 'dbulysse)

; Alternate point between matching parens
(dbulysse-add-keys '(
  ("C-c C-c" (lambda (arg)
    (interactive "p")
          ; Match open paren
    (cond ((looking-at "\\s\(")
            (forward-list 1))
          ; Convenience for matching open paren after C-e
          ((and (looking-back "\\s\(")
                (looking-at "$"))
            (backward-char 1)
            (forward-list 1))
          ; Match close paren
          ((looking-back "\\s\)")
            (backward-list 1)))))
  ))

(setq
  ; Showing matching parens is nearly instantaneous
  show-paren-delay 0.1 
  ; Show matching parentheses when pointer is on them
  show-paren-mode  t
  )

(show-paren-mode)
