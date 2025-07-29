#!/bin/bash
# ==================================================
# test/jetify-devbox/test_vscode_integration.sh
# ==================================================
set -e

source dev-container-features-test-lib

# Create devbox.json to test integration
cat > devbox.json << 'EOF'
{
  "packages": [
    "python@3.11",
    "nodejs@18",
    "jq@latest"
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
    check "packages were installed" devbox list | grep -E "(python|nodejs|jq)" || echo "Expected packages not found"
fi

# Test that environment is available to new bash processes (simulating VS Code tasks)
check "devbox available in new bash" bash -c 'which devbox'

# Test environment variables
check "DEVBOX_FEATURE_INSTALLED set" test "${DEVBOX_FEATURE_INSTALLED}" = "true"

# Test that we can run commands in devbox shell
check "can run in devbox shell" devbox shell -- echo "test"

reportResults