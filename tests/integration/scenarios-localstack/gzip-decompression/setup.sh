#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack SSM and S3 connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" ssm describe-parameters
aws --endpoint-url="${AWS_ENDPOINT_URL}" s3 ls
echo "LocalStack SSM and S3 are accessible."
