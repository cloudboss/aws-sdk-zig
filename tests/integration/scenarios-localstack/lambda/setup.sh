#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack Lambda connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" lambda list-functions
echo "LocalStack Lambda is accessible."
