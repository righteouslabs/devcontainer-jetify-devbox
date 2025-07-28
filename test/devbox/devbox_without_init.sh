#!/bin/bash
set -e

# Check if devbox is installed
if ! command -v devbox &> /dev/null; then
    echo "devbox command not found"
    exit 1
fi

# Verify devbox version works
devbox version

# Success
echo "devbox is installed correctly without initialization"
