" Allow fzf window to be closed with Esc
autocmd! FileType fzf tnoremap <buffer> <ESC> <C-c>

" Start at project root (w/ vim-rooter), dir of current file, or ~/Projects
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :execute 'Files' . expand('%:p:h')<CR>
nnoremap <silent> <leader><A-o> :Files ~/Projects<CR>

nnoremap <silent> <leader>f :Rg<CR>

let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-n': 'split',
\ 'ctrl-v': 'vsplit' }

" Initialize configuration dictionary
let g:fzf_vim = {}
