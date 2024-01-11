augroup Formatting
  autocmd!
  autocmd BufWritePre * call user#TrimWhitespace(1)
  autocmd BufWritePre * lua vim.lsp.buf.format()
augroup END

" Instead of an augroup, these could go into individual files at
" $VIMRUNTIME/after/ftplugin/<filetype>.vim, but is it really worth it?
augroup FtOverrides
  autocmd!
  autocmd FileType sh                setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType ruby,yaml,vim,lua setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType markdown,mkd,text setlocal wrap linebreak
  autocmd FileType markdown,mkd      setlocal conceallevel=2
augroup END

augroup Terminal
  autocmd!
  autocmd TermOpen,BufEnter term://* startinsert
  autocmd TermOpen          *        setlocal nonumber norelativenumber nocursorline
  autocmd TermClose         *        bdelete!
augroup END
