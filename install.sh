#!/bin/bash

set -e

echo "Installing dotfiles..."

mkdir -p ~/.config
cp -r .config/* ~/.config/

cp .bashrc ~/
cp .zshrc ~/

echo "Done. Reboot recommended."

