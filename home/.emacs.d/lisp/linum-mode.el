; Line numbers
(global-linum-mode 1)               ; show line numbers on left
(require 'linum-relative)           ; relative line numbers

(setq 
  ; Line numbers on left for all modes
  global-linum-mode             t
  ; Add a space after line, between text
  linum-format                  'linum-relative     
  ; Show absolute line number for current line
  linum-relative-current-symbol "" 
  ; Ensures 2 digit width on relative line numbers. Adds space between numbers
  ; and text
  linum-relative-format         "%2s "     
  )

(custom-set-faces
 ; Line number colors on the left
 '(linum-relative-current-face ((t (:inherit linum :background "color-54" :foreground "brightwhite"))) nil )
 ; Selected line number color on the left
 '(linum ((t (:background "#000" :foreground "color-227"))))
 )

; TODO: Research post loading hook
(linum-relative-toggle)
(linum-relative-toggle)
