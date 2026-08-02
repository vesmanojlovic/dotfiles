#!/usr/bin/env bash
# Toggle the focused workspace between dwindle and master layout.
# No-ops on DP-2 (portrait) so it stays permanently master+top, per the
# workspace = m[DP-2], layout:master rule in hyprland.conf.

ws_json=$(hyprctl activeworkspace -j)
monitor=$(jq -r '.monitor' <<<"$ws_json")

if [ "$monitor" = "DP-2" ]; then
    exit 0
fi

id=$(jq -r '.id' <<<"$ws_json")
current=$(jq -r '.tiledLayout' <<<"$ws_json")

if [ "$current" = "dwindle" ]; then
    hyprctl keyword workspace "$id, layout:master"
else
    hyprctl keyword workspace "$id, layout:dwindle"
fi
