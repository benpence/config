set visualbell t_vb=""              " disable visual bell
set cursorline                      " highlights current line
set ttyfast                         " for fast connections/local. improves redrawing
set scrolloff=3                     " buffer between cursor line and top/bottom
set relativenumber                  " show relative line numbers fro cursor line
set timeoutlen=400                  " max milliseconds between waiting on keys in a :mapping sequence
set autochdir                       " automatically change directories when opening buffer
syntax on                           " automatic syntax highlighting
set autoindent                      " new line matches current line's indent
set backspace=indent,eol,start      " allows backspacing over autoindent, line breaks, start of insert

""" Save environment on quit
" Backups before write
set backup                          
set backupdir=~/.vim/session/backup

" Undo history
set undofile
set undodir=~/.vim/session/undo

" Placement in buffer
set viewdir=~/.vim/session/view

" History of : and previous search patterns
set history=1000

" Swap files
set dir=~/.vim/session/swp

" Restore registers on open with no file arguments
set viminfo=%,\"4,'100,/100,:100,h,f1
"           |  |  |    |    |    | +-file marks 0-9,A-Z stored ('m' key)
"           |  |  |    |    |    +-don't remember highlighted items
"           |  |  |    |    +-command-line history saved
"           |  |  |    +-search history saved
"           |  |  +-files marks saved
"           |  +-lines saved each register
"           +-save/restore buffer list

if !exists("view_made")
    let view_made = 1
    augroup view
    	autocmd BufWinLeave ?* mkview
    	autocmd BufWinEnter ?* silent loadview
    augroup end
endif

" Coloring tweaks
"colo happy
"highlight NonText guifg=#4a4a59
"highlight SpecialKey guifg=#4a4a59
"highlight SpellBad ctermbg=16 ctermfg=red

""" Command line options
set ruler                           " Ruler on bottom of screen
set showcmd                         " Show (partial) command in the last line
set wildmenu                        " Enhanced command line (* completion)
set wildmode=list:longest           " Tab complete up to longest common string; show possibilty list
" Don't autocomplete these extensions
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.class,*.swp 

""" Security
set modelines=0                     " Don't evaluate options listed in loaded files ie. # vim: set expandtab

""" Tabbing
set tabstop=4                       " number of spaces for existing tabs
set shiftwidth=4                    " number of spaces for each step of (auto)indent (< or >)
set softtabstop=4                   " insert mode tab length 
set expandtab                       " insert spaces instead of tabs
set cindent                         " 
set smartindent                     " 

" Searching
set ignorecase                      " search case insensitively
set smartcase                       " / ? n N case-sensitive with capital letters (requires ignorecase)
set gdefault                        " Reverse effect of 'g' with :substitute (no g -> all, g -> one, gg -> all)
set incsearch                       " Show matches as the search word is being typed
set showmatch                       " on bracket insert, briefly jump to the matching one

""" Split windows
set winminheight=0                  " split windows are collapsible to just statuslines

"Line numbers
set hlsearch

set lbr!                            " wrap long lines by certain characters, not arbitrary

""" Font
set gfn=ProggySquareTTSZ\ 12        " Display in terminal
set guifont=ProggySquareTTSZ\:h16   " Display in GUI

""" Window Tabs
set guitablabel=%t                  " Show tab label shortened
" shift-t new tab
map T :tabnew<Return>               
" ctrl-h tab left
map <C-H> gT                        
" ctrl-l tab right
map <C-L> gt                        

""" Leader mappings
let mapleader=","                   " dynamic prefix for future commands that use <leader>

" For toggling between relative and absolute numbering
function! g:ToggleNumberMode() 
    if(&rnu == 1) 
        set nu 
    else 
        set rnu 
    endif 
endfunc 
nnoremap <leader>n :call g:ToggleNumberMode()<cr>
