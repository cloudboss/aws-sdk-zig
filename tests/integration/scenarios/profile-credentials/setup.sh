#!/bin/bash
set -euo pipefail

echo "Setting up profile-credentials test..."

cat > /tmp/cred-process.sh << 'SCRIPT'
#!/bin/sh
cat << 'EOF'
{
  "Version": 1,
  "AccessKeyId": "AKIAPROCESSTEST",
  "SecretAccessKey": "processSecretTestKey",
  "SessionToken": "processTestToken",
  "Expiration": "2099-01-01T00:00:00Z"
}
EOF
SCRIPT
chmod +x /tmp/cred-process.sh

cat > /tmp/test-profile-config << 'EOF'
[profile test-process]
credential_process = /tmp/cred-process.sh
region = us-east-1
EOF

echo "Profile credentials setup complete."
