__ps1_color() {
    local -A colormap
    colormap=(
        [reset]=0
        [default]=39

        [black]=30
        [red]=31
        [green]=32
        [yellow]=33
        [blue]=34
        [magenta]=35
        [cyan]=36
        [white]=37

        [bright_black]=90
        [bright_red]=91
        [bright_green]=92
        [bright_yellow]=93
        [bright_blue]=94
        [bright_magenta]=95
        [bright_cyan]=96
        [bright_white]=97
    )

    # Octal escapes must be used for brackets when dynamically evaluatng a
    # function call in PS1. (e.g. '\001' instead of '\[')
    printf '\001\033[01;%sm\002' "${colormap[$1]}"
}

__ps1_ec() {
    if (( _LAST_EC != 0 )); then
        echo -n " [$_LAST_EC]"
    fi
}

__ps1_git() {
    # Ensure git is available
    type git &>/dev/null || return

    local result branch tag changes
    branch="$(git branch --show-current 2>/dev/null || :)"

    # Return if not in a git repo
    [[ $branch ]] || return

    tag="$(git describe --tags --exact-match 2>/dev/null || :)"
    changes="$(git status --short 2>/dev/null || :)"

    if [[ $tag ]]; then
        result="◆ ${tag}"
    else
        result=" ${branch}"
    fi

    [[ $changes ]] && result+="*"

    echo -n " [${result}]"
}

__ps1_hostname() {
    # TOOLBOX_NAME is set in ~/.bashrc.d/10-toolbox.sh
    if [[ $TOOLBOX_NAME ]]; then
        echo -n "@${TOOLBOX_NAME}"
    else
        echo -n "@${HOSTNAME%%.*}"
    fi
}

__ps1_toolbox_ssh_hostname() {
    if [[ $TOOLBOX_NAME && $XDG_SESSION_TYPE == "tty" ]]; then
        echo -n ".$(cat /run/host/etc/hostname)"
    fi
}

__ps1_path() {
    local limit result dirparts sub

    limit=40
    result="${PWD/#$HOME/\~}" # substitute $HOME with ~

    # Return early if not over the character limit or checkwinsize is not on
    if (( ${#result} <= limit )) || [[ -z $COLUMNS ]]; then
        echo -n " [${result}]"
        return
    fi

    # Redefine limit based on terminal window width
    limit=$(( COLUMNS - 40 ))

    # Split path into array of directory names
    IFS=/ read -ra dirparts <<<"${result}"

    # Substitute directory names with their first letter until the length of
    # result is less than the character limit
    for d in "${dirparts[@]}"; do
        if (( ${#result} > limit )); then
            sub="${d:0:1}" # first character of directory
            result="${result/$d/$sub}"
        else
            break
        fi
    done

    echo -n " [${result}]"
}

_set_ec() {
    # Store the value of $? so we can act on it in PS1
    # This must be the first thing called by PROMPT_COMMAND
    _LAST_EC=$?
}

_set_ps1() {
    # Default colors
    local user="${PROMPT_THEME[user]:-bright_blue}"
    local host="${PROMPT_THEME[host]:-blue}"
    local tbhn="${PROMPT_THEME[tbhn]:-cyan}"
    local path="${PROMPT_THEME[path]:-white}"
    local icon="${PROMPT_THEME[icon]:-white}"
    local git="${PROMPT_THEME[git]:-yellow}"
    local ec="${PROMPT_THEME[ec]:-bright_red}"

    unset PS1

    # Single-quoted when we want the function *call*, not its result
    PS1+="$(__ps1_color "$user")\u"
    PS1+="$(__ps1_color "$host")"'$(__ps1_hostname)'
    PS1+="$(__ps1_color "$tbhn")"'$(__ps1_toolbox_ssh_hostname)'
    PS1+="$(__ps1_color "$path")"'$(__ps1_path)'
    PS1+="$(__ps1_color "$git")"'$(__ps1_git)'
    PS1+="$(__ps1_color "$ec")"'$(__ps1_ec)'
    PS1+="\n"
    PS1+="$(__ps1_color "$icon")$ "
    PS1+="$(__ps1_color reset)"
}

if [[ -z $PROMPT_COMMAND ]]; then
    PROMPT_COMMAND=(_set_ec)
fi

# Preserve existing PROMPT_COMMAND
if [[ ${PROMPT_COMMAND[0]} != _set_ec ]]; then
    PROMPT_COMMAND=(_set_ec "${PROMPT_COMMAND[@]}")
fi

_set_ps1
