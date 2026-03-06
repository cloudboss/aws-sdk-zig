#!/bin/bash
set -euo pipefail

echo "Setting up web identity test..."

# Create a fake token file
echo "fake-web-identity-token-for-testing" > /tmp/web-identity-token

# Create an IAM role that allows AssumeRoleWithWebIdentity
aws --endpoint-url="${AWS_ENDPOINT_URL}" iam create-role \
    --role-name web-identity-test-role \
    --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Federated":"*"},"Action":"sts:AssumeRoleWithWebIdentity"}]}' \
    2>/dev/null || true

echo "Web identity setup complete."
