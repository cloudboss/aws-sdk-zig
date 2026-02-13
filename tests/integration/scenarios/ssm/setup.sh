#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack SSM connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" ssm describe-parameters
echo "LocalStack SSM is accessible."
