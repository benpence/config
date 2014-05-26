(require 'dbulysse)
(dbulysse-add-keys '(
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
    ("C-c a" org-agenda-list)  ; Agenda
    ))

(dbulysse-add-keys '(
    ; Toggle between showing raw links and description
    ("C-c L" org-toggle-link-display)
    ))

(defun org-agenda-truncate-category (max-width ellipses seperator)
  "A string formatter that truncates the org category to length `max-width', uses `ellipses' to show truncation, and appends `seperator' at the end.

The expression

(let ((category \"primary\"  )) (org-agenda-truncate-category 8 \"...\" \":\")
(let ((category \"secondary\")) (org-agenda-truncate-category 8 \"...\" \":\")

will yield

\"primary :\"
\"secon...:\""
  (let*
    ( (truncated-width
        (min
          (length category)
          max-width))
      (untruncated-width
        (-
          max-width
          truncated-width))
      )

    ; Truncate category?
    (if (< max-width (length category))
        (format
          "%s%s%s"
          ; Category without last _ characters
          (substring
            category
            0
            (-
              max-width
              (length ellipses)))
          ellipses
          seperator)
        (format
          "%s%s%s"
          (substring
            category
            0
            truncated-width)
          ; Space padding
          (make-string
            untruncated-width
            ? )
          seperator))))

; Customizations
(setq
  ; Agenda
  org-agenda-files              '(
                                  "~/Documents/me/wiki/Todo.org"
                                  "~/Documents/me/wiki/Projects.org"
                                  "~/Documents/me/wiki/Magical Mystery Tour.org"
                                 )
  org-agenda-format-date        "%d-%m-%Y"
  ; Agenda starts on today
  org-agenda-start-on-weekday   nil
  ; Show 90 days in the future
  org-agenda-span               90
  ; Only show days
  org-agenda-show-all-dates     nil
  ; Item format
  org-agenda-prefix-format '(
    (agenda . " %i %(org-agenda-truncate-category 16 \"...\" \":\") %?12t% s")
    (timeline . "  % s")
    (todo . " %i %-12:c")
    (tags . " %i %-12:c")
    (search . " %i %-12:c"))
  ; Don't show tags in the agenda
  org-agenda-remove-tags t
  ; What to show when a task is scheduled today / overdue
  org-agenda-scheduled-leaders  '("    " "(%2d)")

  ; TODO changes
  org-archive-save-context-info '(time file category todo priority itags olpath ltags)
  ; Save all archived items in centralized file
  org-archive-location          "~/Documents/me/org_archive::"
  org-log-done                  'time

  org-footnote-auto-adjust      t
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
