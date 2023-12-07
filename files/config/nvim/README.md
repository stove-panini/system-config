neovim config
=============
Vim is configured in Vimscript and Lua plugins are configured in Lua.

- **init.vim** reads the main configuration files in this directory
- **vim-plug.vim** contains the list of plugins and reads their configuration files in [plugins/](plugins/)
- [**autoload/user.vim**](autoload/user.vim) contains some helper functions
- [**ftdetect/user.vim**](ftdetect/user.vim) has extra hints to determine appropriate filetypes

The last two directories are automatically sourced by (neo)vim. Seems like putting them there is "the right way", y'know?
