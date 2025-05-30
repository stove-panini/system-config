"
" ~/.config/nvim/init.vim
"

" Bootstrap vim-plug
let s:vp_path = stdpath('data') . '/site/autoload/plug.vim'
let s:vp_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(s:vp_path))
  silent execute '!curl -fLo ' . s:vp_path . ' --create-dirs ' . s:vp_url
  autocmd VimEnter * PlugInstall --sync | q | source $MYVIMRC
endif

" Plugin List
" -----------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/site/plugged')

" ui
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'srcery-colors/srcery-vim'

" utils
Plug 'airblade/vim-rooter'
"Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" language
Plug 'hrsh7th/vim-vsnip'     " use VSCode snippets
Plug 'neovim/nvim-lspconfig' " configurations for various LSPs

" completion engine & sources
Plug 'hrsh7th/nvim-cmp'      " the completion engine
Plug 'hrsh7th/cmp-nvim-lsp'  " neovim builtin LSP client
Plug 'hrsh7th/cmp-path'      " filesystem path
Plug 'hrsh7th/cmp-vsnip'     " snippets

" syntax
Plug 'HiPhish/jinja.vim'
Plug 'stove-panini/vim-pceas'
Plug 'towolf/vim-helm'

call plug#end()
" -----------------------------------------------------------------------------

" Open vim-plug in a floating window
let g:plug_window = 'call user#FloatWin(50, 70)'

" Close vim-plug window with Esc
autocmd! FileType vim-plug nnoremap <buffer> <silent> <Esc> :q<CR>

" Read configs
runtime! configs/*
