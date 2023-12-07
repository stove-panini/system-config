" Allow fzf window to be closed with Esc
autocmd! FileType fzf tnoremap <buffer> <ESC> <C-c>

" Start at project root (w/ vim-rooter), dir of current file, or ~/Projects
nnoremap <silent> <leader>o :FZF<CR>
nnoremap <silent> <leader>f :call user#FzfHere()<CR>
nnoremap <silent> <leader>F :FZF ~/Projects<CR>

nnoremap <silent> <leader>r :Rg<CR>
nnoremap <silent> <leader>R :Rg ~/Projects<CR>

let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-n': 'split',
\ 'ctrl-v': 'vsplit' }
