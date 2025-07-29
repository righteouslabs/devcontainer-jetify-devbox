#!/bin/bash
# ==================================================
# test/_global/test_all_features.sh
# ==================================================
set -e

source dev-container-features-test-lib

# Test that devbox feature is installed
check "devbox available globally" command -v devbox

reportResults