syntax on  " enable syntax highlighting

filetype indent on  " allow loading of language specific indentation

set background=dark             " use a dark background by default
set backspace=indent,eol,start  " allow backspace to work across lines
set expandtab                   " write tabs as spaces
set number                      " show line numbers
set relativenumber              " relative line numbering
set ruler                       " display ruler in bottom right corner
set shiftwidth=4                " set number of columns to indent with '>' & '<'
set softtabstop=4               " set the number of spaces a tab counts as
set tabstop=4                   " set number of visual spaces per tab
set t_Co=256                    " allow vim to display all colours
set wildmenu                    " turn on autocomplete menu

" use block cursor in normal mode and i-beam in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
set ttimeout
set ttimeoutlen=1
set ttyfast

