#!/bin/bash
# test/devbox/test_vscode_integration.sh
set -e

source dev-container-features-test-lib

# Create a test devbox.json
cat > devbox.json << EOF
{
  "packages": ["python@3.11", "nodejs@18"]
}
EOF

# Run devbox update
check "devbox update succeeds" devbox update

# Test that packages are available in different contexts
check "python in devbox shell" devbox shell -- python3 --version
check "node in devbox shell" devbox shell -- node --version

# Test that environment is available to new bash processes (simulating VS Code tasks)
check "python in new bash process" bash -c 'source ~/.profile && which python3'
check "node in new bash process" bash -c 'source ~/.profile && which node'

# Test environment variables
check "DEVBOX environment set" bash -c 'source ~/.profile && env | grep -q DEVBOX'

reportResults