# Aliases for Silverblue host environment
[[ $TOOLBOX_PATH ]] && return

alias te='toolbox enter'

declare -A PROMPT_THEME
if [[ $SSH_CONNECTION ]]; then
    export PROMPT_THEME=([user]='bright_cyan' [host]='cyan')
fi
