#!/usr/bin/env bash
# Toggle music play/pause, bringing the MPD->MPRIS bridge up first.
#
# The DMS bar only shows music controls while mpd-mpris is running (it bridges
# MPD onto MPRIS for DMS to read/control). music-stop.sh tears that bridge down
# to hide the widget, so before toggling we must start it again -- otherwise
# there'd be no MPRIS player for the playPause call below to act on.

set -u

# Start the bridge if it isn't already up (no-op when already active).
systemctl --user start mpd-mpris
dms ipc call mpris playPause
