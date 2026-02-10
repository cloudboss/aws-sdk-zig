#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack S3 connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" s3 ls
echo "LocalStack S3 is accessible."
