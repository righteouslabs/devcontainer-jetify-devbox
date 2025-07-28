#!/bin/bash
set -e

# Check if devbox is installed
if ! command -v devbox &> /dev/null; then
    echo "devbox command not found"
    exit 1
fi

# Verify devbox version works
devbox version

# Copy the test devbox.json to workspace root
cp /workspaces/*/test/devbox/devbox.json /workspaces/

# Try initialization
cd /workspaces
echo "Current directory: $(pwd)"
echo "Contents of devbox.json:"
cat devbox.json
echo "Running devbox update..."
devbox update

# Success
echo "devbox is installed correctly and initialization works"
