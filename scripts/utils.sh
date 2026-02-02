#!/bin/bash
# Utility functions for dotfiles installation

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if Homebrew is installed
check_homebrew() {
    if ! command_exists brew; then
        error "Homebrew is not installed"
        echo "Install from: https://brew.sh"
        echo "Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    success "Homebrew is installed"
}

# Check if Xcode Command Line Tools are installed
check_xcode_tools() {
    if ! xcode-select -p &> /dev/null; then
        warn "Xcode Command Line Tools not found, installing..."
        xcode-select --install
        echo "Please run this script again after installation completes"
        exit 1
    fi
    success "Xcode Command Line Tools installed"
}

# Stow packages with conflict handling
stow_package() {
    local package=$1
    local target=${2:-$HOME}

    if [ ! -d "$DOTFILES_DIR/$package" ]; then
        warn "Package '$package' not found, skipping"
        return 1
    fi

    # Try to stow, handle conflicts
    if stow -d "$DOTFILES_DIR" -t "$target" "$package" 2>/dev/null; then
        success "Stowed $package"
    else
        warn "Conflict detected for $package, restowing..."
        stow -d "$DOTFILES_DIR" -t "$target" --restow "$package"
        success "Restowed $package"
    fi
}

# Stow multiple packages
stow_packages() {
    for package in "$@"; do
        stow_package "$package"
    done
}
