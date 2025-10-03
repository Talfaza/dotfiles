#!/bin/bash

# 1. Grab real touchpad device (skip "Mouse")
TOUCHPAD_NAME=$(xinput list --name-only | grep -i "touchpad" | grep -vi "mouse" | head -n1)

if [ -z "$TOUCHPAD_NAME" ]; then
    echo "❌ No proper touchpad found."
    exit 1
fi

# 2. Get Device ID
TOUCHPAD_ID=$(xinput list --id-only "$TOUCHPAD_NAME")
echo "🎯 Touchpad: $TOUCHPAD_NAME (ID=$TOUCHPAD_ID)"

# 3. Pull out property ID number only
PROP_ID=$(xinput list-props "$TOUCHPAD_ID" \
  | grep -m1 "Tapping Enabled (" \
  | sed -E 's/.*KATEX_INLINE_OPEN([0-9]+)KATEX_INLINE_CLOSE.*/\1/')

if [ -z "$PROP_ID" ]; then
    echo "❌ Could not extract property ID for 'Tapping Enabled'."
    exit 1
fi
echo "🔑 Property 'Tapping Enabled' has ID=$PROP_ID"

# 4. Actually enable it
xinput set-prop "$TOUCHPAD_ID" "$PROP_ID" 1

# 5. Confirm
STATE=$(xinput list-props "$TOUCHPAD_ID" | grep "Tapping Enabled (" | awk '{print $NF}')
if [ "$STATE" = "1" ]; then
    echo "✅ Tapping enabled!"
else
    echo "⚠️ Still disabled… something interfered (Wayland or desktop may override)."
fi
