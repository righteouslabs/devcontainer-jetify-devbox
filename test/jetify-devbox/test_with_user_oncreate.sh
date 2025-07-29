#!/bin/bash

set -e

echo "Testing Devbox feature with user onCreate command..."

source dev-container-features-test-lib

check "devbox is installed" which devbox
check "devbox version works" devbox version
check "devbox feature installed env var" bash -c "[ \"\$DEVBOX_FEATURE_INSTALLED\" = 'true' ]"

check "user onCreate command ran" test -f /tmp/user-oncreate.log
check "user onCreate content" grep "User onCreate ran after feature" /tmp/user-oncreate.log

check "post-setup script exists" test -f /usr/local/share/devbox-post-setup.sh
check "manual setup script exists" test -f /usr/local/bin/devbox-setup

reportResults