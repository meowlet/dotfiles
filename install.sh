#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing Homebrew packages..."
brew install eza bat starship fastfetch zsh-syntax-highlighting zsh-autosuggestions stow

echo "==> Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow zsh starship ghostty bat fastfetch

echo "==> Done! Open a new terminal to see the changes."
