augroup Formatting
  au!
  au BufWritePre * call user#TrimWhitespace(1)
  au BufWritePre * lua vim.lsp.buf.format()

  au BufWritePost *.pkr.hcl,*.pkrvars.hcl call user#ExtCmd("packer fmt")
augroup END

" This could also go in ftdetect/user.vim but I like it in one file
augroup FtDetect
  au!
  au BufNewFile,BufRead */ansible/*/[^.]*.yml setlocal ft=yaml.ansible
  au BufNewFile,BufRead */ansible/*/hosts     setlocal ft=ansible_hosts
  au BufNewFile,BufRead */manifests/*.pp      setlocal ft=puppet

  au BufNewFile,BufRead */pce/*/*.asm,*/pce/*/*.inc setlocal ft=pceas
augroup END

" Instead of an augroup, these could go into individual files at
" $VIMRUNTIME/after/ftplugin/<filetype>.vim, but is it really worth it?
augroup FtOverrides
  au!
  au FileType sh                          setlocal sw=4 ts=4
  au FileType ruby,yaml,vim,lua,terraform setlocal sw=2 ts=2
  au FileType markdown,mkd,text           setlocal wrap linebreak
  au FileType markdown,mkd                setlocal conceallevel=2 nomodeline
  au FileType pceas                       setlocal noexpandtab sw=8 ts=8 nolist
augroup END

augroup Terminal
  au!
  au TermOpen,BufEnter term://* startinsert
  au TermOpen          *        setlocal nonumber norelativenumber nocursorline
  au TermClose         *        bdelete!
augroup END
