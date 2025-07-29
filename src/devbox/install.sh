#!/bin/sh

# Stop the script on error
set -e

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

# Create post-setup script for devbox update
cat << 'EOF' > /usr/local/share/devbox-post-setup.sh
#!/bin/bash
set -e

# Log output for debugging
exec 1> >(tee -a /tmp/devbox-setup.log)
exec 2>&1

echo "Running Devbox post-installation setup..."

# Check if devbox.json exists in workspace
if [ -f "${WORKSPACE_FOLDER:-/workspaces/*}/devbox.json" ]; then
    echo "Found devbox.json, running devbox update..."
    cd "${WORKSPACE_FOLDER:-/workspaces/*}"
    
    # Run as the remote user if not root
    if [ "${_REMOTE_USER}" != "root" ]; then
        su ${_REMOTE_USER} -c 'devbox update'
    else
        devbox update
    fi
    
    # Also set up the shell environment for VS Code processes
    devbox shellenv --init-hook >> ~/.profile
else
    echo "No devbox.json found, skipping devbox update"
fi

echo "Devbox setup completed successfully"
EOF

# Make the post-setup script executable
chmod +x /usr/local/share/devbox-post-setup.sh
