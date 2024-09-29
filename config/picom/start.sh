#!/bin/bash

if pgrep picom > /dev/null; then
    pkill picom
    sleep 1
fi

echo "Starting Picom..."
picom &

