#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MOCK_DIR="${SCRIPT_DIR}/../../mocks"
PORT=8099
PID_FILE="/tmp/imds-mock-credentials.pid"

echo "Starting mock IMDS server on port ${PORT}..."
python3 "${MOCK_DIR}/imds_server.py" "${PORT}" &
echo $! > "${PID_FILE}"

for i in $(seq 1 10); do
    if curl -sf -X PUT \
        -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" \
        "http://127.0.0.1:${PORT}/latest/api/token" \
        >/dev/null 2>&1; then
        echo "Mock IMDS server is ready (PID $(cat "${PID_FILE}"))."
        exit 0
    fi
    sleep 0.5
done

echo "Mock IMDS server failed to start."
kill "$(cat "${PID_FILE}")" 2>/dev/null || true
rm -f "${PID_FILE}"
exit 1
