#!/usr/bin/env bash

# Updates the label when the frontmost app changes
if [ "$SENDER" = "front_app_switched" ]; then
    sketchybar --set "$NAME" label="$INFO"
fi
