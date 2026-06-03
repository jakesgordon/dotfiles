#!/usr/bin/env bash
# Launch a terminal and consume it into the current column (a niri "split").
#
# niri can't open a window directly into an existing column, so we:
#   1. start listening to the IPC event stream BEFORE spawning,
#   2. spawn the terminal,
#   3. wait for a genuinely new window to open (a window id we hadn't seen),
#   4. consume it leftward into the column it launched from.

set -u

TERM_CMD=${1:-ghostty}

# Snapshot the window ids that already exist.
seen=" $(niri msg --json windows | jq -r '.[].id' | tr '\n' ' ') "

# Start the event stream before spawning so we can't miss the open event.
coproc EV { niri msg --json event-stream; }

"$TERM_CMD" & disown

while IFS= read -r line <&"${EV[0]}"; do
    # Only WindowOpenedOrChanged carries a window object; ignore everything else.
    id=$(jq -r 'if has("WindowOpenedOrChanged") then .WindowOpenedOrChanged.window.id else empty end' <<<"$line" 2>/dev/null)
    [ -z "$id" ] && continue

    # Skip events for windows that already existed (title/focus changes, etc.).
    case "$seen" in *" $id "*) continue ;; esac

    niri msg action consume-or-expel-window-left
    break
done

kill "$EV_PID" 2>/dev/null
