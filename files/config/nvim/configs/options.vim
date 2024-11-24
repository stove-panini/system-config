" Allow 24-bit color in the terminal
set termguicolors

" Hide default modeline
set noshowmode

" Show line numbers
set number

" Highlight current line
set cursorline

" No line wrap
set nowrap

" Use spaces
set expandtab

" Tab size
set tabstop=4

" Indent operation (<< and >>) size
set shiftwidth=4

" Show tabs and trailing spaces (listchars defined by vim-sensible)
set list

" Search case-insensitive unless upper case chars are present
set ignorecase
set smartcase

" All registers use system clipboard
set clipboard+=unnamedplus

" Direction of new splits
set splitbelow "split/new
set splitright "vsplit/vnew

" Disable netrw
let loaded_netrwPlugin = 1
