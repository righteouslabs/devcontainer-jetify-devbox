#!/bin/bash
set -e

# Import test library
source dev-container-features-test-lib

# Feature-specific tests
check "devbox installed" devbox version
check "nix available" nix --version

# Test workspace integration
check "can run devbox update" bash -c "touch devbox.json && devbox update"
check "devbox shell works" devbox shell -- echo 'Shell test passed'

# Test VS Code integration
check "environment persisted to profile" grep -q "devbox shellenv" ~/.profile || echo "Profile updated"

# Test package management
check "can add package" devbox add ripgrep@latest
check "package available" devbox shell -- which rg

# Cleanup
rm -f devbox.json devbox.lock

reportResults