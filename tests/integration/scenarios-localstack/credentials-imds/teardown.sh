#!/bin/bash
PID_FILE="/tmp/imds-mock-credentials.pid"
if [[ -f "${PID_FILE}" ]]; then
    kill "$(cat "${PID_FILE}")" 2>/dev/null || true
    rm -f "${PID_FILE}"
fi
