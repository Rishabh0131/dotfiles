#!/bin/bash

# Get current and max brightness
cur=$(brightnessctl g)
max=$(brightnessctl m)

# Calculate percentage
percent=$(( cur * 100 / max ))

# Output ONE clean line (plain text)
echo "󰃠 ${percent}%"
