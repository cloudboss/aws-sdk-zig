#!/bin/bash
set -euo pipefail

echo "Creating temp config file for config-resolution test..."

cat > /tmp/test-aws-config << 'EOF'
[default]
max_attempts = 7
retry_mode = adaptive
EOF

echo "Config file created at /tmp/test-aws-config"
