#!/usr/bin/env bash

PERCENTAGE=$(pmset -g batt | grep -Eo '\d+%' | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
    exit 0
fi

if [ "$PERCENTAGE" -ge 91 ]; then
    GLYPH=$(printf '\xef\x89\x80')
elif [ "$PERCENTAGE" -ge 61 ]; then
    GLYPH=$(printf '\xef\x89\x81')
elif [ "$PERCENTAGE" -ge 31 ]; then
    GLYPH=$(printf '\xef\x89\x82')
elif [ "$PERCENTAGE" -ge 11 ]; then
    GLYPH=$(printf '\xef\x89\x83')
else
    GLYPH=$(printf '\xef\x89\x84')
fi

if [ -n "$CHARGING" ]; then
    BOLT=$(printf '\xef\x83\xa7')
    GLYPH="${GLYPH}${BOLT}"
fi

# Low-battery warning pill (red when < 15% and not charging)
if [ "$PERCENTAGE" -lt 15 ] && [ -z "$CHARGING" ]; then
    sketchybar --set "$NAME" \
        icon="${PERCENTAGE} %" \
        label="$GLYPH" \
        icon.color=0xffffffff \
        label.color=0xffffffff \
        background.drawing=on \
        background.color=0xffff5257 \
        background.corner_radius=5 \
        background.height=20 \
        background.padding_left=6 \
        background.padding_right=6
else
    sketchybar --set "$NAME" \
        icon="${PERCENTAGE} %" \
        label="$GLYPH" \
        icon.color=0xffe5e5e5 \
        label.color=0xffe5e5e5 \
        background.drawing=off
fi
