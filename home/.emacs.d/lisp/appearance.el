; Bars
(menu-bar-mode 0)                   ; disable menubar on frames
(column-number-mode t)              ; show column in mode line

; Line numbers
(global-linum-mode 1)               ; show line numbers on left
(require 'linum-relative)           ; relative line numbers

; Color Theme
(setq custom-safe-themes t)
(load-theme 'oak)
