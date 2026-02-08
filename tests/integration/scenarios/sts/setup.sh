#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack STS connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" sts get-caller-identity
echo "LocalStack STS is accessible."
