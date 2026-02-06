#!/bin/bash
set -euo pipefail

PID_FILE="/tmp/imds-mock.pid"

if [[ -f "${PID_FILE}" ]]; then
    echo "Stopping mock IMDS server (PID $(cat "${PID_FILE}"))..."
    kill "$(cat "${PID_FILE}")" 2>/dev/null || true
    rm -f "${PID_FILE}"
fi
