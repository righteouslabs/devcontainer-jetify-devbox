#!/bin/sh

# Reference: https://github.com/dlouwers/devcontainer-features/blob/main/src/devbox/install.sh

# Add Nix channel for devbox
nix-channel --add https://nixos.org/channels/nixpkgs-unstable

# Update Nix channels
nix-channel --update

# Install devbox using Nix profile
nix profile install nixpkgs#devbox \
    --extra-experimental-features flakes \
    --extra-experimental-features nix-command

# Ensure devbox is available in the PATH
if ! command -v devbox >/dev/null 2>&1; then
    echo "devbox installation failed. Please check the logs for errors."
    exit 1
fi

echo "devbox installed successfully."

# Initialize repo if requested
if [ "${INITREPO}" = "true" ]; then
    echo "Initializing repository with devbox update..."
    
    # Change to the workspace root directory
    cd "${CONTAINERWORKSPACEFOLDER}"
    
    if [ ! -f "devbox.json" ]; then
        echo "Warning: devbox.json not found in repository root. Skipping initialization."
        exit 0
    fi
    
    echo "Running devbox update in $(pwd)..."
    devbox update
fi