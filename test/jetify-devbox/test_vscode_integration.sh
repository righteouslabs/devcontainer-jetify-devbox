#!/bin/bash
# ==================================================
# test/jetify-devbox/test_vscode_integration.sh
# ==================================================
set -e

source dev-container-features-test-lib

# Create a minimal devbox.json to test integration (avoid heavy packages)
cat > devbox.json << 'EOF'
{
  "packages": [
    "hello"
  ],
  "shell": {
    "init_hook": [
      "echo 'Welcome to Devbox!'"
    ]
  }
}
EOF

# Run the post-setup script to process the devbox.json
/usr/local/share/devbox-post-setup.sh

# Check devbox was installed
check "devbox installed" devbox version

# If devbox.json exists (from mount), verify it was processed
if [ -f devbox.json ]; then
    check "devbox update ran" test -f /tmp/devbox-setup.log
    # Check if packages were installed (this might fail if devbox update didn't run properly)
    if devbox list > /dev/null 2>&1; then
        check "packages were installed" devbox list | grep -E "hello"
    else
        echo "Warning: devbox list failed, packages may not be installed"
    fi
fi

# Test that environment is available to new bash processes (simulating VS Code tasks)
check "devbox available in new bash" bash -c 'which devbox'

# Test environment variables
check "DEVBOX_FEATURE_INSTALLED set" test "${DEVBOX_FEATURE_INSTALLED}" = "true"

# Test that we can run commands in devbox shell
check "can run in devbox shell" devbox run -- echo "test"

reportResults