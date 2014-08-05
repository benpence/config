(require 'dbulysse)

(dbulysse-add-keys '(
    ("C-c C" dbulysse-org-todo-columns)
    ; Toggle between showing raw links and description
    ("C-c L" org-toggle-link-display)
    )
  'org-mode-hook)

(dbulysse-add-keys '(
    ("C-c c" org-capture) ; Create task from text
    ("C-c a" org-agenda)  ; Agenda
    ))

; Customizations
(setq
  ; Agenda
  org-agenda-files              '(
                                  "~/Documents/me/wiki/Todo.org"
                                  "~/Documents/me/wiki/Projects.org"
                                  "~/Documents/me/wiki/Travel.org"
                                  "~/Documents/me/wiki/Spark.org"
                                  "~/Documents/me/wiki/Recurring.org"
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
    (agenda . " %i %(dbulysse-org-truncate-category 8 \"~\" \":\") %?12t% s")
    (timeline . "  % s")
    (todo . " %i %-12:c")
    (tags . " %i %(dbulysse-org-truncate-category 8 \"~\" \":\") %?12t% s")
    (search . " %i %-12:c"))
  ; Don't show tags in the agenda
  org-agenda-remove-tags        t
  ; What to show when a task is scheduled today / overdue
  org-agenda-scheduled-leaders  '("    " "(%2d)")
  ; Do not display time grid in agenda
  org-agenda-use-time-grid      nil

  ; TODO changes
  org-archive-save-context-info '(time file category todo priority itags olpath ltags)
  ; Save all archived items in centralized file
  org-archive-location          "~/Documents/me/org_archive::"
  org-log-done                  'time

  org-footnote-auto-adjust      t
  ; Start up showing all headlines
  org-startup-folded            'content
  org-startup-indented          t
  )

; Face customizations
(custom-set-faces
 ; Background for org column view
 '(org-column ((t (:background "grey10" :strike-through nil :underline nil :slant normal :weight normal))))
 ; Specific headline levels
 '(outline-2 ((t (:inherit font-lock-string-face))))
 '(outline-8 ((t (:inherit font-lock-variable-name-face))))
 )
