#!/usr/bin/env bash

# Toggles the overview popup when triggered externally (e.g., from BTT)
# Bind BTT 3-finger swipe up to:
#   sketchybar --trigger aerospace_overview_toggle

source "$HOME/.config/sketchybar/plugins/icon_map.sh"

if [ "$SENDER" = "aerospace_overview_toggle" ]; then
    # Rebuild popup contents before showing
    # Remove any stale popup children
    existing=$(sketchybar --query default_menu_items 2>/dev/null || true)

    # (Simple version: just toggle for now — content generation deferred)
    sketchybar --set "$NAME" popup.drawing=toggle
fi
