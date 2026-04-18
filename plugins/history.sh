#!/usr/bin/env bash
# Render the 10-slot AeroSpace history queue. Fixed width: empty slots keep
# their reserved space so the widget doesn't jitter as the queue grows.
# All slots share font and color; the active slot gets a thin underline
# (configured per-item in sketchybarrc; we only toggle its drawing here).

set -euo pipefail

HIST=/Users/skril/.config/aerospace/scripts/history.sh

FILLED_COLOR=0xffd0d0d0
EMPTY_COLOR=0xff505050

# Workspace 10 is labeled "0" to match its keyboard binding (alt-ctrl-cmd-0).
display_label() {
    case "$1" in
        10) echo "0" ;;
        *)  echo "$1" ;;
    esac
}

SLOTS=()
while IFS= read -r line; do
    SLOTS+=("$line")
done < <("$HIST" slots)

for i in 0 1 2 3 4 5 6 7 8 9; do
    raw="${SLOTS[$i]:-}"
    if [[ -z "$raw" ]]; then
        sketchybar --set history.$i \
            label="*" \
            label.color="$EMPTY_COLOR"
    elif [[ "${raw:0:1}" == "=" ]]; then
        sketchybar --set history.$i \
            label="[$(display_label "${raw:1}")]" \
            label.color="$FILLED_COLOR"
    else
        sketchybar --set history.$i \
            label="$(display_label "${raw:1}")" \
            label.color="$FILLED_COLOR"
    fi
done
