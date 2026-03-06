#!/bin/bash
set -euo pipefail

echo "Setting up assume role test..."

# Create an IAM role that allows AssumeRole
aws --endpoint-url="${AWS_ENDPOINT_URL}" iam create-role \
    --role-name phase8-assume-role-test \
    --assume-role-policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"AWS":"*"},"Action":"sts:AssumeRole"}]}' \
    2>/dev/null || true

echo "Assume role setup complete."
