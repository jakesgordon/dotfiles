#!/usr/bin/env bash
# Stop music and hide the DMS bar's music controls.
#
# Stops MPD playback first (via DMS's MPRIS IPC, while the player still exists),
# then stops the mpd-mpris bridge. Tearing down the bridge unregisters the
# MPRIS player from D-Bus, which makes the DMS bar's music widget disappear --
# it only renders while a player is present. music-toggle.sh is the inverse.

set -u

dms ipc call mpris stop
systemctl --user stop mpd-mpris
