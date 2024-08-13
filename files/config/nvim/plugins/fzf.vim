" Allow fzf window to be closed with Esc
autocmd! FileType fzf tnoremap <buffer> <ESC> <C-c>

" Start at project root (w/ vim-rooter), dir of current file, or ~/Projects
nnoremap <silent> <leader>o :FZF<CR>
nnoremap <silent> <leader>O :FZF ~/Projects<CR>
nnoremap <silent> <leader><A-o> :call user#FzfHere()<CR>

nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>F :Rg ~/Projects<CR>

let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-n': 'split',
\ 'ctrl-v': 'vsplit' }
