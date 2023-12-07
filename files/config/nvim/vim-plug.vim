" Bootstrap vim-plug
let s:vim_plug_filepath = stdpath('data') . '/site/autoload/plug.vim'

if empty(glob(s:vim_plug_filepath))
  silent execute '!curl -fLo ' . s:vim_plug_filepath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin List
" -----------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/site/plugged')

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" ui
Plug 'srcery-colors/srcery-vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'

" utils
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" syntax
Plug 'sheerun/vim-polyglot'

call plug#end()
" -----------------------------------------------------------------------------

" Open vim-plug in a floating window
let g:plug_window = 'call user#FloatWin(30, 70)'

" Read plugin configs
runtime! plugins/*.vim plugins/*.lua
