#!/usr/bin/env bash
#
# 10-no-wifi-when-wired.sh - turns wifi off when a wired connection is present
#

# Exit if not dealing with an ethernet device
[[ "$1" == en* ]] || exit 0

case "$2" in
  up) nmcli radio wifi off ;;
  down) nmcli radio wifi on ;;
esac
