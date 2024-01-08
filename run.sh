#!/usr/bin/env bash

if [[ ! $TOOLBOX_PATH ]]; then
    echo "Only run this from inside a Toolbox!" >&2
    exit 1
fi

case $1 in
    --host)
        opts=(-Kk)
        playbook=Silverblue.yml
        ;;
    '')
        opts=()
        playbook=Toolbox.yml
        ;;
    *)
        echo "Run with --host to configure Silverblue host"
        exit
esac

declare -A pkg_cmds
pkg_cmds=(
    [apk]="apk update && apk add"
    [apt]="apt update && apt install -y"
    [dnf]="dnf install -y"
    [pacman]="pacman --noconfirm -S"
)

for i in "${!pkg_cmds[@]}"; do
    if type "$i" &>/dev/null; then
        sudo ${pkg_cmds[$i]} ansible sshpass
        break
    fi
done

ansible-galaxy install -r requirements.yml
ansible-playbook "${opts[@]}" "$playbook"
