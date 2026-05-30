#!/usr/bin/env bash
#
# Brightness helper for Sway (systemd-logind + a mako progress notification).
#
#   brightness.sh up     raise backlight 5%
#   brightness.sh down   lower backlight 5%
#
# Adjusts the backlight via logind's D-Bus SetBrightness method — the same path
# GNOME uses. logind (running as root) performs the privileged sysfs write on
# behalf of whoever owns the active session, so this needs NO root and NO
# `video` group membership. Then pops a mako notification with a progress bar,
# in its own synchronous hint group ("brightness") so it never clobbers the
# volume popup.
#
# Bound from sway/config (XF86MonBrightness* keys).
set -euo pipefail

mode=${1:-}

# brightnessctl -m prints "name,class,current,percent,max" for the default
# device (still useful purely for *reading* — no permissions needed for that).
IFS=, read -r device subsystem cur _ max < <(brightnessctl -m)
step=$(( max * 5 / 100 ))

case "$mode" in
  up)   new=$(( cur + step )) ;;
  down) new=$(( cur - step )) ;;
  *)
    echo "usage: brightness.sh up|down" >&2
    exit 64
    ;;
esac

# Clamp to the device's valid range.
(( new > max )) && new=$max
(( new < 0 ))   && new=0

# logind owns the device; the active-session check is the credential (no group).
busctl call org.freedesktop.login1 /org/freedesktop/login1/session/auto \
  org.freedesktop.login1.Session SetBrightness ssu "$subsystem" "$device" "$new"

pct=$(( (new * 100 + max / 2) / max ))

# -h x-canonical-private-synchronous:brightness -> replace the previous popup
# -h int:value:N                                -> draw mako's progress bar
notify-send \
  -a brightness \
  -t 1000 \
  -i display-brightness \
  -h string:x-canonical-private-synchronous:brightness \
  -h "int:value:$pct" \
  "Brightness ${pct}%"
