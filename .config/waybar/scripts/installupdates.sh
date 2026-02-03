#!/usr/bin/env bash
set -e

# ------------------------------------------------------
# Helpers
# ------------------------------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ------------------------------------------------------
# UI Confirmation
# ------------------------------------------------------

sleep 1
clear

if command_exists figlet; then
    figlet -f smslant "Updates"
    echo
fi

primarycolor="#904b3d"
onsurfacecolor="#231917"

if command_exists gum; then
    if gum confirm \
        --selected.background="$primarycolor" \
        --prompt.foreground="$onsurfacecolor" \
        "DO YOU WANT TO START THE UPDATE NOW?"; then
        echo
        echo ":: Update started..."
    else
        echo
        echo ":: Update canceled."
        exit 0
    fi
else
    echo ":: gum not installed — proceeding with update"
fi

# ------------------------------------------------------
# Install Updates (Arch Linux)
# ------------------------------------------------------

if command_exists pacman; then
    if command_exists paru; then
        paru -Syu --noconfirm
    elif command_exists yay; then
        yay -Syu --noconfirm
    else
        echo ":: No AUR helper found (paru / yay)"
        exit 1
    fi
else
    echo ":: pacman not found — unsupported system"
    exit 1
fi

echo
echo "✔ System update completed successfully"
