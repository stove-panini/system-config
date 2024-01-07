# Aliases for Silverblue host environment
if [[ ! $TOOLBOX_PATH ]]; then

    alias te='toolbox enter'

    declare -A PROMPT_THEME
    if [[ $SSH_CONNECTION ]]; then
        export PROMPT_THEME=([user]='bright_cyan' [host]='cyan')
    fi
fi
