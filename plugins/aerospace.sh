#!/usr/bin/env bash

source "$HOME/.config/sketchybar/plugins/icon_map.sh"

WORKSPACE_ID="$1"

if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

apps=()
while IFS= read -r app_name; do
    [ -z "$app_name" ] && continue
    apps+=("$app_name")
done < <(aerospace list-windows --workspace "$WORKSPACE_ID" --format "%{app-name}" 2>/dev/null)

n=${#apps[@]}

resolve_icon() {
    __icon_map "$1"
    printf "%s" "$icon_result"
}

icon_s0=""
icon_s1=""
[ "$n" -ge 1 ] && icon_s0="$(resolve_icon "${apps[0]}")"
[ "$n" -eq 2 ] && icon_s1="$(resolve_icon "${apps[1]}")"
[ "$n" -ge 3 ] && icon_s1="…"

if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
    ICON_COLOR=0xffffffff
    ICON_FONT="FiraCode Nerd Font:Bold:13.0"
    LABEL_COLOR=0xffffffff
else
    ICON_COLOR=0xff707070
    ICON_FONT="FiraCode Nerd Font:Regular:12.0"
    LABEL_COLOR=0xff707070
fi

# Single batched invocation reduces latency on rapid switches
sketchybar \
    --set "space.$WORKSPACE_ID" \
        icon.color="$ICON_COLOR" \
        icon.font="$ICON_FONT" \
    --set "space.$WORKSPACE_ID.s0" \
        label="$icon_s0" \
        label.color="$LABEL_COLOR" \
    --set "space.$WORKSPACE_ID.s1" \
        label="$icon_s1" \
        label.color="$LABEL_COLOR"
