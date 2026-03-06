#!/bin/bash
set -euo pipefail

echo "Waiting for LocalStack EC2 service..."
for i in $(seq 1 15); do
    if aws --endpoint-url="${AWS_ENDPOINT_URL}" ec2 describe-vpcs >/dev/null 2>&1; then
        echo "LocalStack EC2 is accessible."
        exit 0
    fi
    sleep 2
done

echo "LocalStack EC2 failed to become ready, proceeding anyway..."
