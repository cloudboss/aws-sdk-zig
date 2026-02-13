#!/bin/bash
set -euo pipefail

echo "Verifying LocalStack SQS connectivity..."
aws --endpoint-url="${AWS_ENDPOINT_URL}" sqs list-queues
echo "LocalStack SQS is accessible."
