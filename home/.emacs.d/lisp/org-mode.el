(require 'dbulysse)
(dbulysse-add-keys '(
    ("C-c a" org-agenda)  ; Agenda
    ("C-c c" org-capture) ; Create task from text
    ("C-c C" (lambda ()   ; Show TODO items in column view
      (interactive)
      ; Already showing this information?
      ; TODO find better columns view detection
      (if (and (boundp 'org-columns-begin-marker)
               (eql
                 (marker-buffer org-columns-begin-marker)
                 (current-buffer)))
          ; Clear columns and highlights
          (progn
            (org-columns-quit)
            (org-remove-occur-highlights)
            (org-content))
          ; Show columns (file-wide) and highlights
          (save-excursion
            (org-show-todo-tree nil)
            ;(org-sparse-tree)
            ; TODO insert newline and then remove it
            (beginning-of-buffer)
            (insert "\n")
            ; TODO use (window-width) to truncate ITEM formatter
            (org-columns (concat
              "%28ITEM %TODO %SCHEDULED %TAGS"))
            (delete-char 1)
          ))))
    )
  'org-mode-hook)

(dbulysse-add-keys '(
    ; Toggle between showing raw links and description
    ("C-c L" org-toggle-link-display)
    ))

; Customizations
(setq
  org-agenda-files              '("~/Documents/me/")
  org-archive-save-context-info '(time file category todo priority itags olpath ltags)
  org-footnote-auto-adjust      t
  org-log-done                  'time
  ; Start up showing all headlines
  org-startup-folded            'content 
  org-startup-indented t
  )

; Face customizations
(custom-set-faces
 ; Background for org column view
 '(org-column ((t (:background "grey10" :strike-through nil :underline nil :slant normal :weight normal))))
 ; Specific headline levels
 '(outline-2 ((t (:inherit font-lock-string-face))))
 '(outline-8 ((t (:inherit font-lock-variable-name-face))))
 )
