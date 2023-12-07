#!/usr/bin/env bash

case $1 in
    --host)
        opts=(-Kk)
        playbook=host.yml
        ;;
    '')
        opts=()
        playbook=container.yml
        ;;
    *)
        echo "Run with --host to configure MicroOS"
        exit
esac

declare -A pm_cmds
pm_cmds=(
    [apt]="apt update && apt install -y"
    [dnf]="dnf install -y"
    [pacman]="pacman --noconfirm -S"
    [zypper]="zypper install -y"
)

for i in "${!pm_cmds[@]}"; do
    if command -v "$i" &>/dev/null; then
        sudo ${pm_cmds[$i]} ansible sshpass
    break
    fi
done

ansible-galaxy install -r requirements.yml
ansible-playbook "${opts[@]}" "$playbook"
