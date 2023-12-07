# For the love of god, no Ctrl+S, Ctrl+Q
[[ $- == *i* ]] && stty -ixon -ixoff

# Global aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ls='ls --color=auto --classify --human-readable --group-directories-first'
alias ll='ls -l'
alias la='ll --almost-all'
