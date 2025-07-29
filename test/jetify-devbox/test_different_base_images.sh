#!/bin/bash

set -e

echo "Testing Devbox feature on different base image (ubuntu:jammy)..."

source dev-container-features-test-lib

check "devbox is installed" which devbox
check "devbox version works" devbox version
check "devbox feature installed env var" bash -c "[ \"\$DEVBOX_FEATURE_INSTALLED\" = 'true' ]"

check "post-setup script exists" test -f /usr/local/share/devbox-post-setup.sh
check "manual setup script exists" test -f /usr/local/bin/devbox-setup
check "auto-update flag exists" test -f /usr/local/share/devbox-auto-update-enabled

check "devbox init works" bash -c "cd /tmp && devbox init"
check "devbox.json created" test -f /tmp/devbox.json

reportResults