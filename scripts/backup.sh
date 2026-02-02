#!/bin/bash
# Backup existing dotfiles before stowing

BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Files and directories to backup
BACKUP_TARGETS=(
    "$HOME/.zshrc"
    "$HOME/.zprofile"
    "$HOME/.zsh"
    "$HOME/.hushlogin"
    "$HOME/.config/starship.toml"
    "$HOME/.config/ghostty"
    "$HOME/.config/bat"
    "$HOME/.config/fastfetch"
    "$HOME/.gitconfig"
    "$HOME/.gitignore_global"
)

backup_configs() {
    local backed_up=false

    for target in "${BACKUP_TARGETS[@]}"; do
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            if [ "$backed_up" = false ]; then
                mkdir -p "$BACKUP_DIR"
                backed_up=true
            fi

            local relative_path="${target#$HOME/}"
            local backup_path="$BACKUP_DIR/$relative_path"

            mkdir -p "$(dirname "$backup_path")"
            cp -r "$target" "$backup_path"
            echo "Backed up: $target"
        fi
    done

    if [ "$backed_up" = true ]; then
        echo "Backup created at: $BACKUP_DIR"
    else
        echo "No existing configs to backup"
    fi
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    backup_configs
fi
