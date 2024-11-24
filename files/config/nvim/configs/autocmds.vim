augroup Formatting
  autocmd!
  autocmd BufWritePre * call user#TrimWhitespace(1)
  autocmd BufWritePre * lua vim.lsp.buf.format()

  autocmd BufWritePost *.pkr.hcl,*.pkrvars.hcl call user#ExtCmd("packer fmt")
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

" This could also go in ftdetect/user.vim but I like it in one file
augroup FtDetect
  autocmd!
  autocmd BufNewFile,BufRead */ansible/*/[^.]*.yml setlocal filetype=yaml.ansible
  autocmd BufNewFile,BufRead */ansible/*/hosts     setlocal filetype=ansible_hosts
  autocmd BufNewFile,BufRead */manifests/*.pp      setlocal filetype=puppet
augroup END

augroup Terminal
  autocmd!
  autocmd TermOpen,BufEnter term://* startinsert
  autocmd TermOpen          *        setlocal nonumber norelativenumber nocursorline
  autocmd TermClose         *        bdelete!
augroup END
