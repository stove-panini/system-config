#!/usr/bin/env bash

set -e

declare -A settings custom_keybindings

settings=(
    # No automatic suspend on AC power
    [org.gnome.settings-daemon.plugins.power/sleep-inactive-ac-timeout]="0"

    # File retention
    [org.gnome.desktop.privacy/old-files-age]="uint32 7"
    [org.gnome.desktop.privacy/recent-files-max-age]="-1"
    [org.gnome.desktop.privacy/remember-recent-files]="false"
    [org.gnome.desktop.privacy/remove-old-temp-files]="true"
    [org.gnome.desktop.privacy/remove-old-trash-files]="true"

    # Static workspaces
    [org.gnome.mutter/dynamic-workspaces]="false"
    [org.gnome.desktop.wm.preferences/num-workspaces]="4"

    # GNOME Shell UI
    [org.gnome.desktop.interface/clock-show-weekday]="true"
    [org.gnome.desktop.interface/show-battery-percentage]="false"

    # Workspace navigation
    [org.gnome.desktop.wm.keybindings/move-to-workspace-1]="['<Shift><Super>1']"
    [org.gnome.desktop.wm.keybindings/move-to-workspace-2]="['<Shift><Super>2']"
    [org.gnome.desktop.wm.keybindings/move-to-workspace-3]="['<Shift><Super>3']"
    [org.gnome.desktop.wm.keybindings/move-to-workspace-4]="['<Shift><Super>4']"
    [org.gnome.desktop.wm.keybindings/switch-to-workspace-1]="['<Super>1']"
    [org.gnome.desktop.wm.keybindings/switch-to-workspace-2]="['<Super>2']"
    [org.gnome.desktop.wm.keybindings/switch-to-workspace-3]="['<Super>3']"
    [org.gnome.desktop.wm.keybindings/switch-to-workspace-4]="['<Super>4']"

    # Clear out app launcher shortcuts
    [org.gnome.shell.keybindings/switch-to-application-1]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-2]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-3]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-4]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-5]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-6]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-7]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-8]="@as []"
    [org.gnome.shell.keybindings/switch-to-application-9]="@as []"

    # Swap capslock & ctrl, map compose key to right alt
    [org.gnome.desktop.input-sources/xkb-options]="['caps:ctrl_modifier', 'compose:ralt', 'lv3:switch']"

    # Search providers
    [org.gnome.desktop.search-providers/enabled]="['org.gnome.Calculator.desktop', 'org.gnome.Characters.desktop']"
    [org.gnome.desktop.search-providers/sort-order]="['org.gnome.Contacts.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Nautilus.desktop']"

    # No event sounds
    [org.gnome.desktop.sound/event-sounds]="false"

    # Nautilus / file-chooser
    [org.gnome.nautilus.icon-view/default-zoom-level]="'small'"
    [org.gnome.nautilus.list-view/default-zoom-level]="'small'"
    [org.gnome.nautilus.preferences/default-folder-viewer]="'list-view'"
    [org.gtk.Settings.FileChooser/sort-directories-first]="true"
    [org.gtk.gtk4.Settings.FileChooser/sort-directories-first]="true"
)


custom_keybindings=(
    [0/binding]="'<Super><Shift>Return'"
    [0/command]="'gnome-terminal --profile Host'"
    [0/name]="'Launch Terminal (Host)'"

    [1/binding]="'<Super>Return'"
    [1/command]="'gnome-terminal --profile Toolbox'"
    [1/name]="'Launch Terminal (Toolbox)'"
)

# =============================================================================

slice() {
    cut -d "/" -f "$2" <<<"$1"
}

gsetter() {
    local schema="$1"
    local key="$2"
    local val="$3"

    if [[ $(gsettings get "$schema" "$key") != "$val" ]]; then
        gsettings set "$schema" "$key" "$val"
        CHANGED=1
    fi
}

CHANGED=0

# Write config
for i in "${!settings[@]}"; do
    schema="$(slice "$i" 1)"
    key="$(slice "$i" 2)"
    val="${settings[$i]}"

    gsetter "$schema" "$key" "$val"
done

# Exit if no custom keybindings are set
if [[ ${#custom_keybindings[@]} == 0 ]]; then
    echo $CHANGED
    exit
fi

ck_schema="org.gnome.settings-daemon.plugins.media-keys"
ck_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
ck_list=""

# Write custom keybindings definitions
for i in "${!custom_keybindings[@]}"; do
    idx="$(slice "$i" 1)"
    key="$(slice "$i" 2)"
    val="${custom_keybindings[$i]}"

    gsetter "${ck_schema}.custom-keybinding:${ck_path}/custom${idx}/" "$key" "$val"

    # Add one of each index to the custom keybindings list
    if [[ $key == "name" ]]; then
        ck_list+="'${ck_path}/custom${idx}/', "
    fi
done

# Write the custom keybindings list, removing trailing ", "
gsetter "${ck_schema}" "custom-keybindings" "[${ck_list%, }]"

echo -n $CHANGED
