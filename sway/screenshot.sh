#!/usr/bin/env bash
#
# Screenshot helper for Sway (grim + slurp, edited/saved in satty).
#
#   screenshot.sh full     capture the whole screen
#   screenshot.sh region   pick a region with slurp
#
# The capture is piped straight into satty (no temp file). From there:
#   Ctrl+S saves to $save (pattern below), Ctrl+C copies to the clipboard,
#   Esc discards. --early-exit closes satty right after a save or copy.
#
# Bound from sway/config (Print / $mod+Print).
set -euo pipefail

# Where Ctrl+S saves. satty expands ~ and strftime format specifiers itself.
save="$HOME/downloads/screenshot.%Y-%m-%d.%H:%M:%S.png"

mode=${1:-full}

grim_args=()
case "$mode" in
  full)
    ;;
  region)
    # slurp prints geometry; if the user hits Esc it exits non-zero -> abort.
    geom=$(slurp) || exit 0
    grim_args=(-g "$geom")
    ;;
  *)
    echo "usage: screenshot.sh full|region" >&2
    exit 64
    ;;
esac

# Shutter click (freedesktop camera-shutter sound, via PipeWire's pw-play).
# Backgrounded so it doesn't hold up the editor; guarded so a missing player
# or sound file never breaks the capture.
shutter=/usr/share/sounds/freedesktop/stereo/camera-shutter.oga
command -v pw-play >/dev/null && [ -f "$shutter" ] && pw-play "$shutter" &

# Capture to stdout and hand it to satty; satty owns saving and clipboard.
grim "${grim_args[@]}" - | satty -f - --output-filename "$save" --copy-command wl-copy --initial-tool rectangle --early-exit
