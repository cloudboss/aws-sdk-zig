#!/bin/bash
set -euo pipefail

echo "Waiting for LocalStack IAM service..."
for i in $(seq 1 15); do
    if aws --endpoint-url="${AWS_ENDPOINT_URL}" iam list-users >/dev/null 2>&1; then
        echo "LocalStack IAM is accessible."
        exit 0
    fi
    sleep 2
done

echo "LocalStack IAM failed to become ready, proceeding anyway..."
