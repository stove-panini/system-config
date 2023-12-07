" Set leader key to space
nnoremap <Space> <nop>
let mapleader = " "

" Split control
nnoremap <silent> <C-w>n :new<CR>
nnoremap <silent> <C-w>v :vnew<CR>
nnoremap <silent> <C-w>N :split<CR>
nnoremap <silent> <C-w>V :vsplit<CR>

" Tab control
nnoremap <silent> tc :tabnew<CR>
nnoremap <silent> tn :tabnext<CR>
nnoremap <silent> tN :tabprev<CR>

" Clear search results with Enter
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Reload nvim config
nnoremap <silent> <leader><C-r> :source $MYVIMRC \| echo 'Reloaded' $MYVIMRC<CR>

" Be kind to our pinkies
nnoremap ; :

" Open terminal in a split
nnoremap <silent> <leader>t :call user#Term('vnew')<CR>
nnoremap <silent> <leader>T :call user#Term('new')<CR>

" Return to normal mode in terminal with Esc
tnoremap <Esc> <C-\><C-n>

" LSP
nnoremap <silent> <leader>e :lua vim.diagnostic.open_float()<CR>
nnoremap <silent> [d        :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d        :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>q :lua vim.diagnostic.setloclist()<CR>

" Only map these when a language server is available
augroup LocalLSP
  autocmd!
  autocmd LspAttach *
  \ nnoremap <buffer> <silent> gd    :lua vim.lsp.buf.definition()<CR> |
  \ nnoremap <buffer> <silent> gD    :lua vim.lsp.buf.declaration()<CR> |
  \ nnoremap <buffer> <silent> gi    :lua vim.lsp.buf.implementation()<CR> |
  \ nnoremap <buffer> <silent> gt    :lua vim.lsp.buf.type_definition()<CR> |
  \ nnoremap <buffer> <silent> gr    :lua vim.lsp.buf.references()<CR> |
  \ nnoremap <buffer> <silent> K     :lua vim.lsp.buf.hover()<CR> |
  \ nnoremap <buffer> <silent> <C-n> :lua vim.lsp.buf.rename()<CR> |
  \ nnoremap <buffer> <silent> <C-f> :lua vim.lsp.buf.format()<CR>
augroup END
