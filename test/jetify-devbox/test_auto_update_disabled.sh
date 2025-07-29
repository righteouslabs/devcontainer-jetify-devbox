#!/bin/bash
# ==================================================
# test/jetify-devbox/test_auto_update_disabled.sh
# ==================================================
set -e

source dev-container-features-test-lib

# Check that the post-setup script was created
check "post-setup script exists" test -f /usr/local/share/devbox-post-setup.sh

# Check that manual helper script was also created
check "manual setup helper exists" test -f /usr/local/bin/devbox-setup

# Check that auto-update is disabled
check "auto-update disabled flag" grep -q "false" /usr/local/share/devbox-auto-update-enabled

# Check that no automatic setup log exists
check "no automatic setup log" test ! -f /tmp/devbox-setup.log

# Test manual setup helper
check "manual setup helper is executable" test -x /usr/local/bin/devbox-setup

# Create a test devbox.json and run manual setup
cat > devbox.json << EOF
{
  "packages": ["jq@latest"]
}
EOF

check "manual setup runs successfully" devbox-setup

# Verify devbox is functional
check "devbox works" devbox version

# Cleanup
rm -f devbox.json devbox.lock

reportResults