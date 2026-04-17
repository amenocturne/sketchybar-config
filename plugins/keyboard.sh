#!/usr/bin/env bash

# AppleCurrentKeyboardLayoutInputSourceID is the reliable live value.
source_id=$(defaults read com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null)

case "$source_id" in
    *colemakdh*|*Colemak*) label="CODH" ;;
    *Russian*|*russian*)   label="RU"   ;;
    *ABC*|*.US|*.US-*)     label="EN"   ;;
    *)
        suffix="${source_id##*.}"
        label=$(printf '%s' "$suffix" | tr '[:lower:]' '[:upper:]' | cut -c1-4)
        ;;
esac

KB_GLYPH=$(printf '\xef\x84\x9c')

sketchybar --set "$NAME" icon="$label" label="$KB_GLYPH"
