#!/bin/bash
# Dotfiles installer
# Usage: ./install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source utilities
source "$DOTFILES_DIR/scripts/utils.sh"
source "$DOTFILES_DIR/scripts/backup.sh"

echo "======================================"
echo "       Dotfiles Installation          "
echo "======================================"
echo ""

# Check prerequisites
info "Checking prerequisites..."
check_xcode_tools
check_homebrew

# Backup existing configs
info "Backing up existing configs..."
backup_configs

# Install Homebrew packages
info "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Stow dotfiles
info "Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow_packages zsh starship ghostty bat fastfetch git

echo ""
echo "======================================"
success "Installation complete!"
echo "======================================"
echo ""
echo "Open a new terminal to see changes."
echo ""
