syntax on           " enable syntax highlighting
filetype plugin on  " allow loading of language specific indentation

set background=dark             " use a dark background by default
set backspace=indent,eol,start  " allow backspace to work across lines
set expandtab                   " write tabs as spaces
set number                      " show hybrid relative line numbers
set ruler                       " display ruler in bottom right corner
set shiftwidth=4                " set number of columns to indent with '>' & '<'
set softtabstop=4               " set the number of spaces a tab counts as
set tabstop=4                   " set number of visual spaces per tab
set t_Co=256                    " allow vim to display all colours
set wildmenu                    " turn on autocomplete menu
set nowrap                      " no word wrapping (this is my preference)
set nofoldenable                " disable folding

" Toggle between relative and absolute line numbers
" REF: https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

