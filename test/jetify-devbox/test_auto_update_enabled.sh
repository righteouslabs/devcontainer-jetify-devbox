#!/bin/bash
# ==================================================
# test/jetify-devbox/test_auto_update_enabled.sh
# ==================================================
set -e

source dev-container-features-test-lib

# Check that the post-setup script was created
check "post-setup script exists" test -f /usr/local/share/devbox-post-setup.sh

# Check that onCreateCommand was executed
check "devbox setup log exists" test -f /tmp/devbox-setup.log

# Check log contents
check "devbox update was attempted" grep -q "Running Devbox post-installation setup" /tmp/devbox-setup.log

# If devbox.json was copied, check it was processed
if [ -f devbox.json ]; then
    check "devbox.json was processed" grep -q "Found devbox.json" /tmp/devbox-setup.log
    check "devbox update ran" grep -q "running devbox update" /tmp/devbox-setup.log
fi

# Check that environment was set up
check "profile updated" grep -q "devbox shellenv" ~/.profile || echo "Profile not updated (might be expected)"

# Verify devbox is functional
check "devbox works" devbox version

reportResults