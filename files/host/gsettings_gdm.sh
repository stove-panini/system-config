#!/usr/bin/env bash

set -e

schema="org.gnome.settings-daemon.plugins.power"
key="sleep-inactive-ac-timeout"
val=0

gdm_gs() {
      sudo -u gdm dbus-run-session -- gsettings "$@"
}

CHANGED=0

if [[ $(gdm_gs get $schema $key) != "$val" ]]; then
      gdm_gs set $schema $key $val
      CHANGED=1
fi

echo -n $CHANGED
