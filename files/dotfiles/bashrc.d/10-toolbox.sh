# Configs for Toolbox
[[ $TOOLBOX_PATH ]] || return

# Use per-toolbox history files
source /run/.containerenv
export TOOLBOX_NAME="$name" # Used later in PS1
HISTFILE="${HOME}/.bash_history.${TOOLBOX_NAME}"

# Set prompt theme
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

gr() {
    local repo_root
    repo_root="$(git rev-parse --show-toplevel)"

    echo "Changing to repo's root dir..."
    cd "$repo_root"
}

gH() (
    # ^ This func uses a subshell ( ... ), not a compound command { ... } so
    # that I can use "set" and not have it affect the caller
    set -euo pipefail

    local main_branch
    local -a branches
    main_branch=$(basename "$(git rev-parse --abbrev-ref origin/HEAD)")

    git checkout "$main_branch"
    git pull

    readarray -t branches < <(
        git branch --merged | grep -v -e '^\*' -e "$main_branch"
    )

    for branch in "${branches[@]}"; do
        # Trim leading spaces from branch name and delete it
        git branch -d "${branch#  }"
    done
)

certinfo() {
    echo -n Q \
        | openssl s_client -servername "$1" -connect "${1}:443" \
        | openssl x509 -noout -dates
}

serve() {
    # Python's http.server dies when serving ISOs to iLO but not Ruby's :)

    # Not "run" but "require un". Crazy. https://github.com/ruby/un
    ruby -run -e httpd -- --port "${1:-8000}" .
}

geoip() {
    curl "https://api.hackertarget.com/geoip/?q=$1"
    echo
}
