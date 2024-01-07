#!/usr/bin/env bash

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

declare -A pm_cmds
pm_cmds=(
    [apk]="apk update && apk add"
    [apt]="apt update && apt install -y"
    [dnf]="dnf install -y"
    [pacman]="pacman --noconfirm -S"
)

for i in "${!pm_cmds[@]}"; do
    if command -v "$i" &>/dev/null; then
        sudo ${pm_cmds[$i]} ansible sshpass
    break
    fi
done

ansible-galaxy install -r requirements.yml
ansible-playbook "${opts[@]}" "$playbook"
