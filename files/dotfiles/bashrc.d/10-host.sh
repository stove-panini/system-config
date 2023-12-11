# Aliases for MicroOS host environment
if [[ ! $DISTROBOX_ENTER_PATH ]]; then

    alias tu='sudo transactional-update'
    alias de='distrobox enter'

    declare -A PROMPT_THEME
    if [[ $SSH_CONNECTION ]]; then
        export PROMPT_THEME=([user]='bright_cyan' [host]='cyan')
    fi
fi
