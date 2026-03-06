#!/bin/bash
set -euo pipefail

echo "Setting up profile-env-var test..."

cat > /tmp/test-profile-credentials << 'EOF'
[default]
aws_access_key_id = AKIADEFAULTDONOTUSE
aws_secret_access_key = DefaultSecretDoNotUse

[custom-profile]
aws_access_key_id = AKIACUSTOMPROFILE
aws_secret_access_key = CustomProfileSecretKey
EOF

echo "Credentials file created at /tmp/test-profile-credentials"
