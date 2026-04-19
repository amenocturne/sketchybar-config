#!/usr/bin/env bash

# Mirrors workspace 10's pill onto whichever display matches the AeroSpace pin:
# - 2+ monitors: workspace 10 lives on the secondary display, so its pill
#   (and its leading separator) move to display 2.
# - Solo: workspace 10 collapses onto the only monitor, so the pill returns
#   to display 1 and the separator before it is shown.

COUNT=$(/opt/homebrew/bin/aerospace list-monitors --count)

if [ "$COUNT" -ge 2 ]; then
    TARGET=2
    SEP_DRAWING=off
else
    TARGET=1
    SEP_DRAWING=on
fi

sketchybar \
    --set space.10        display=$TARGET \
    --set space.10.s0     display=$TARGET \
    --set space.10.s1     display=$TARGET \
    --set space.10.pad    display=$TARGET \
    --set space.sep.9     drawing=$SEP_DRAWING
