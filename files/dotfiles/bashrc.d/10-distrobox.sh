# Configs for Distrobox
if [[ $DISTROBOX_ENTER_PATH ]]; then
    declare -A PROMPT_THEME
    export PROMPT_THEME=([user]='bright_green' [host]='green')

    alias k='kubectl'
    alias vim='nvim'
    alias vimdiff='nvim -d'

    alias gc='git checkout'
    alias gC='git commit'
    alias gs='git status'
    alias gd='git diff'
    alias gp='git pull'
    alias gP='git push'

    gH() {
        # H like uh... git home?
        # Switches to main branch and deletes local branches that've been merged
        local main_branch
        main_branch=$(basename "$(git rev-parse --abbrev-ref origin/HEAD)")

        git checkout "$main_branch"
        git pull
        git branch --merged \
            | grep -v -e '^\*' -e "$main_branch" \
            | xargs git branch -d
    }

    certinfo() {
        echo -n Q \
            | openssl s_client -servername "$1" -connect "${1}:443" \
            | openssl x509 -noout -dates
    }
fi
