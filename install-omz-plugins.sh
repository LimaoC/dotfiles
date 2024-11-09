#!/bin/bash

# Usage: ./install-omz-plugins.sh

# Installs oh-my-zsh plugins TO $ZSH_CUSTOM/plugins

repos=(
    "https://github.com/zsh-users/zsh-autosuggestions"
    "https://github.com/zsh-users/zsh-syntax-highlighting"
    "https://github.com/lukechilds/zsh-nvm"
)

# Install each plugin in their respective directory, if not already installed
for i in "${!repos[@]}"; do
    repo="${repos[$i]}"
    repo_name=$(basename "$repo")
    target_dir="$ZSH_CUSTOM/plugins/$repo_name"

    if [ ! -d "$target_dir" ]; then
        git clone $repo $target_dir
    else
        echo "install-omz-plugins: Skipping $repo_name (already installed)" >&2
    fi
done

