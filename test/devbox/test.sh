#!/bin/bash

# This test file will be run in a container with the feature installed
set -e

# Feature should have installed devbox
if ! command -v devbox &> /dev/null; then
    echo "devbox command not found"
    exit 1
fi

# Check if devbox is working
devbox version

# Success
echo "devbox is working correctly"
