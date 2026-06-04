#!/usr/bin/env bash
#
# Watch niri for completed screenshots and open each one in satty to annotate.
#
# We keep niri's native screenshot UI/behaviour (Print / Ctrl+Print / Alt+Print
# stay bound to screenshot / screenshot-screen / screenshot-window). niri always
# copies the capture to the clipboard and emits a ScreenshotCaptured event on its
# IPC event-stream; we listen for that and hand the clipboard image to satty.
#
# screenshot-path is set to null in config.kdl, so niri does NOT save to disk -
# satty owns saving (Ctrl+S -> $save) and copying (Ctrl+C -> clipboard).
#
# Started via spawn-sh-at-startup from niri/config.kdl.
set -euo pipefail

# Where satty's Ctrl+S saves. satty expands ~ and strftime format specifiers.
save="$HOME/downloads/screenshot.%Y-%m-%d.%H:%M:%S.png"

niri msg --json event-stream | while IFS= read -r line; do
  case "$line" in
    *'"ScreenshotCaptured"'*)
      # Backgrounded so a slow editor session doesn't stall the event loop.
      wl-paste --type image/png | satty -f - \
        --output-filename "$save" --copy-command wl-copy \
        --initial-tool rectangle --early-exit &
      ;;
  esac
done
