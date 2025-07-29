#!/bin/bash
# ==================================================
# test/jetify-devbox/test.sh - Basic functionality test
# ==================================================
set -e

# Import test library
source dev-container-features-test-lib

# Feature-specific tests
check "devbox installed" devbox version
check "nix available" nix --version

# Check that devbox is in PATH
check "devbox in PATH" which devbox

# Test basic devbox functionality
check "can initialize devbox" bash -c "devbox init && test -f devbox.json"

# Test that devbox shell works
check "devbox shell works" bash -c "echo 'echo Shell test passed' | devbox shell"

# Cleanup
rm -f devbox.json devbox.lock

reportResults