" Vim color file
" Maintainer:	Ben Pence <vim@benpence.com>
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

" Colors
"   Hex     256     Description
"   ---     ---     -----------
"   #3b2d96 54      Dark Purplish Blue
"   #89A6ff 111     Sky Blue
"   #65985d 65      Darkish Green
"   #f5b168 215     Tan Orange
"   #fff74D 227     Yellow
"   #a34b42 131     Maroon
"   #6a93bd 67      Darkish Bluish Gray
"   #6aacb3 73      Darkish Teal
"   #c5bc79         Greenish Wood (unused)

let colors_name     = "oak"
let g:colors_name   = "oak"

"               term            cterm|ctermfg|ctermbg                     gui|guifg|guibg
"               ----            ---------------------                     ---------------
hi Normal       term=NONE       cterm=NONE      ctermfg=15   ctermbg=NONE gui=NONE      guifg=#ffffff guibg=#000000

hi Comment      term=NONE       cterm=NONE      ctermfg=111  ctermbg=NONE gui=NONE      guifg=#89A6ff guibg=NONE
hi link Todo Comment
hi link goTodo Todo

hi LineNr       term=NONE       cterm=NONE      ctermfg=227  ctermbg=NONE gui=NONE      guifg=#fff74D guibg=NONE
hi CursorLine   term=underline  cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE    guibg=NONE
hi Visual       term=reverse    cterm=reverse   ctermfg=none ctermbg=NONE gui=reverse   guifg=NONE    guibg=NONE

hi String       term=NONE       cterm=NONE      ctermfg=65   ctermbg=NONE gui=NONE      guifg=#65985d guibg=NONE
                                                                         
                                                           
hi link pythonString String

hi Number       term=NONE       cterm=NONE      ctermfg=73   ctermbg=NONE gui=NONE      guifg=#6aacb3 guibg=NONE

hi Statement    term=NONE       cterm=NONE      ctermfg=215  ctermbg=NONE gui=NONE      guifg=#f5b168 guibg=NONE
hi link Operator Statement
hi link Keyword Statement

hi PreProc      term=NONE       cterm=NONE      ctermfg=67   ctermbg=NONE gui=NONE      guifg=#6a93bd guibg=NONE
hi link Include Preproc 

hi Type                         cterm=NONE      ctermfg=131  ctermbg=NONE gui=NONE      guifg=#a34b42 guibg=NONE
hi link Function Type 
hi link xmlEndTag Function
