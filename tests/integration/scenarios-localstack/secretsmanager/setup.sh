#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack Secrets Manager connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" secretsmanager list-secrets
echo "LocalStack Secrets Manager is accessible."
