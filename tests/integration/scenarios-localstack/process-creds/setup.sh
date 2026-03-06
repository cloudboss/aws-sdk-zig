#!/bin/bash
set -euo pipefail

echo "Setting up process credentials test..."

# Create a credential helper script that returns valid JSON
cat > /tmp/cred-helper.sh << 'SCRIPT'
#!/bin/sh
cat << 'EOF'
{
  "Version": 1,
  "AccessKeyId": "AKIAPROCESS123",
  "SecretAccessKey": "processSecretKey123",
  "SessionToken": "processToken123",
  "Expiration": "2099-01-01T00:00:00Z"
}
EOF
SCRIPT
chmod +x /tmp/cred-helper.sh

# Create a failing credential helper
cat > /tmp/cred-helper-fail.sh << 'SCRIPT'
#!/bin/sh
echo "credential helper failed" >&2
exit 1
SCRIPT
chmod +x /tmp/cred-helper-fail.sh

echo "Process credentials setup complete."
