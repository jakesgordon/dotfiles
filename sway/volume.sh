#!/usr/bin/env bash
#
# Volume helper for Sway (wpctl + a mako progress notification).
#
#   volume.sh up     raise default sink 5% (capped at 100%)
#   volume.sh down   lower default sink 5%
#   volume.sh mute   toggle mute on the default sink
#
# Adjusts the volume, then pops a mako notification with a progress bar
# showing the new level. The notifications share a synchronous hint group
# ("volume") so repeated presses replace the popup in place instead of
# stacking, and expire quickly like an on-screen display.
#
# Bound from sway/config (XF86Audio* keys).
set -euo pipefail

sink="@DEFAULT_AUDIO_SINK@"
mode=${1:-}

case "$mode" in
  up)   wpctl set-volume -l 1.0 "$sink" 5%+ ;;
  down) wpctl set-volume -l 1.0 "$sink" 5%- ;;
  mute) wpctl set-mute "$sink" toggle ;;
  *)
    echo "usage: volume.sh up|down|mute" >&2
    exit 64
    ;;
esac

# wpctl prints e.g. "Volume: 0.40" or "Volume: 0.40 [MUTED]".
state=$(wpctl get-volume "$sink")
pct=$(awk '{ print int($2 * 100 + 0.5) }' <<<"$state")

if [[ "$state" == *MUTED* ]]; then
  icon=audio-volume-muted
  summary="Volume muted"
  value=0
else
  case "$pct" in
    0)            icon=audio-volume-muted ;;
    [1-9]|[1-3]?) icon=audio-volume-low ;;
    [4-6]?)       icon=audio-volume-medium ;;
    *)            icon=audio-volume-high ;;
  esac
  summary="Volume ${pct}%"
  value=$pct
fi

# -h x-canonical-private-synchronous:volume  -> replace the previous popup
# -h int:value:N                             -> draw mako's progress bar
notify-send \
  -a volume \
  -t 1000 \
  -i "$icon" \
  -h string:x-canonical-private-synchronous:volume \
  -h "int:value:$value" \
  "$summary"
