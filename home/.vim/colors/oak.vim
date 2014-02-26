" Vim color file
" Maintainer:	Ben Pence <vim@benpence.com>
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name     = "oak"
let g:colors_name   = "oak"

"               term            cterm|ctermfg|ctermbg                     gui|guifg|guibg
"               ----            ---------------------                     ---------------
hi Normal       term=NONE       cterm=NONE      ctermfg=15   ctermbg=NONE gui=NONE      guifg=#ffffff guibg=#000000

hi Comment      term=NONE       cterm=NONE      ctermfg=111  ctermbg=NONE gui=NONE      guifg=#89A6ff guibg=NONE
hi link Todo Comment

hi LineNr       term=NONE       cterm=NONE      ctermfg=227  ctermbg=NONE gui=NONE      guifg=#fff74D guibg=NONE
hi CursorLine   term=underline  cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE    guibg=NONE
hi Visual       term=reverse    cterm=reverse   ctermfg=none ctermbg=NONE gui=reverse   guifg=NONE    guibg=NONE

hi Constant     term=NONE       cterm=NONE      ctermfg=73   ctermbg=NONE gui=NONE      guifg=#6aacb3 guibg=NONE
hi link Number Constant
hi String       term=NONE       cterm=NONE      ctermfg=65   ctermbg=NONE gui=NONE      guifg=#65985d guibg=NONE
hi link Character String

hi Statement    term=NONE       cterm=NONE      ctermfg=215  ctermbg=NONE gui=NONE      guifg=#f5b168 guibg=NONE

hi PreProc      term=NONE       cterm=NONE      ctermfg=67   ctermbg=NONE gui=NONE      guifg=#6a93bd guibg=NONE

hi Special      term=NONE       cterm=NONE      ctermfg=186  ctermbg=NONE gui=NONE      guifg=#dfdf87 guibg=NONE

hi Identifier   term=NONE       cterm=NONE      ctermfg=131  ctermbg=NONE gui=NONE      guifg=#af5f5f guibg=NONE

hi Type         term=NONE       cterm=NONE      ctermfg=146  ctermbg=NONE gui=NONE      guifg=#afafd7 guibg=NONE

hi Underlined   term=NONE       cterm=underline ctermfg=230  ctermbg=NONE gui=underline guifg=#ffffdf guibg=NONE

" *Comment          any comment
"
" *Constant         any constant
"  String           a string constant: "this is a string"
"  Character        a character constant: 'c', '\n'
"  Number           a number constant: 234, 0xff
"  Boolean          a boolean constant: TRUE, false
"  Float            a floating point constant: 2.3e10
"
" *Identifier       any variable name
"  Function         function name (also: methods for classes)
"
" *Statement        any statement
"  Conditional          if, then, else, endif, switch, etc.
"  Repeat           for, do, while, etc.
"  Label            case, default, etc.
"  Operator         "sizeof", "+", "*", etc.
"  Keyword          any other keyword
"  Exception        try, catch, throw
"
" *PreProc          generic Preprocessor
"  Include          preprocessor #include
"  Define           preprocessor #define
"  Macro            same as Define
"  PreCondit        preprocessor #if, #else, #endif, etc.
"
" *Type             int, long, char, etc.
"  StorageClass     static, register, volatile, etc.
"  Structure        struct, union, enum, etc.
"  Typedef          A typedef
"
" *Special          any special symbol
"  SpecialChar      special character in a constant
"  Tag              you can use CTRL-] on this
"  Delimiter        character that needs attention
"  SpecialComment   special things inside a comment
"  Debug            debugging statements
"
" *Underlined       text that stands out, HTML links
"
" *Ignore           left blank, hidden  |hl-Ignore|
"
" *Error            any erroneous construct
"
" *Todo             anything that needs extra attention; mostly the
"                   keywords TODO FIXME and XXX
