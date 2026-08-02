#!/usr/bin/env bash
# Reset window sizes to uniform on the landscape monitor (DP-1) when it's
# using dwindle. No-ops on the portrait monitor (always master) or when
# DP-1 is currently toggled to master.
#
# Hyprland's dwindle layoutmsg has no single "reset whole tree" command -
# `splitratio <val> exact` only resets the split immediately adjacent to
# the focused window's node. We cycle focus through every window on the
# workspace and reset each one's adjacent split, which covers the common
# 2-3 window case fully; with 4+ windows in an unbalanced tree, splits
# further up the tree may need a second pass.

ws_json=$(hyprctl activeworkspace -j)
monitor=$(jq -r '.monitor' <<<"$ws_json")

if [ "$monitor" != "DP-1" ]; then
    exit 0
fi

if [ "$(jq -r '.tiledLayout' <<<"$ws_json")" != "dwindle" ]; then
    exit 0
fi

ws_id=$(jq -r '.id' <<<"$ws_json")
original_addr=$(hyprctl activewindow -j | jq -r '.address // empty')

mapfile -t addrs < <(hyprctl clients -j | jq -r --argjson ws "$ws_id" '.[] | select(.workspace.id == $ws and .floating == false) | .address')

for addr in "${addrs[@]}"; do
    hyprctl dispatch focuswindow "address:$addr" >/dev/null
    hyprctl dispatch layoutmsg "splitratio 1.0 exact" >/dev/null
done

if [ -n "$original_addr" ]; then
    hyprctl dispatch focuswindow "address:$original_addr" >/dev/null
fi
