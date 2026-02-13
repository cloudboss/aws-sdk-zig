#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack SNS connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" sns list-topics
echo "LocalStack SNS is accessible."
