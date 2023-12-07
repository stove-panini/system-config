# Aliases for MicroOS host environment
if [[ ! $DISTROBOX_ENTER_PATH ]]; then
    alias de='distrobox enter'
    alias serve='podman run --rm -p 8080:80 -v $(pwd):/var/lib/nginx/html:ro,Z dceoy/nginx-autoindex'

    declare -A PROMPT_THEME
    if [[ $SSH_CONNECTION ]]; then
        export PROMPT_THEME=([user]='bright_cyan' [host]='cyan')
    else
        export PROMPT_THEME=([user]='bright_blue' [host]='blue')
    fi
fi
