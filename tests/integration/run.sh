#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIOS_DIR="${SCRIPT_DIR}/scenarios"
CERT_DIR="${SCRIPT_DIR}/certs"
LOCALSTACK_CONTAINER=""
LOCALSTACK_IMG="${LOCALSTACK_IMG:-localstack/localstack:4.3.0}"
ZIG_BUILD_FLAGS="${ZIG_BUILD_FLAGS:-}"
TLS_CERT_HOST_PATH="${TLS_CERT_HOST_PATH:-}"
# Filter to single scenario if SCENARIO is set
if [[ -n "${SCENARIO:-}" ]]; then
    SCENARIO_DIRS=("${SCENARIOS_DIR}/${SCENARIO}/")
else
    SCENARIO_DIRS=("${SCENARIOS_DIR}"/*/)
fi

# Aggregate services from scenario directories
SERVICES=""
for scenario_dir in "${SCENARIO_DIRS[@]}"; do
    if [[ -f "${scenario_dir}/services" ]]; then
        while IFS= read -r svc; do
            svc=$(echo "$svc" | xargs)
            [[ -z "$svc" || "$svc" == \#* ]] && continue
            if [[ -z "$SERVICES" ]]; then
                SERVICES="$svc"
            elif [[ ",${SERVICES}," != *",${svc},"* ]]; then
                SERVICES="${SERVICES},${svc}"
            fi
        done < "${scenario_dir}/services"
    fi
done
TLS_MODE=false
PASS=0
FAIL=0
ERRORS=()

if [[ "${1:-}" == "--tls" ]]; then
    TLS_MODE=true
    shift
fi

# --- LocalStack lifecycle ---

cleanup() {
    if [[ -n "${LOCALSTACK_CONTAINER}" ]]; then
        echo "Stopping LocalStack..."
        docker rm -f "${LOCALSTACK_CONTAINER}" 2>/dev/null || true
    fi
}
trap cleanup EXIT

start_localstack() {
    echo "Starting LocalStack..."

    local container_id
    container_id=$(grep -o '[0-9a-f]\{64\}' /proc/self/cgroup 2>/dev/null | head -1 || true)
    if [[ -z "${container_id}" ]]; then
        container_id=$(hostname 2>/dev/null || true)
    fi

    if [[ -z "${container_id}" ]] || ! docker inspect "${container_id}" >/dev/null 2>&1; then
        echo "ERROR: Could not detect container ID" >&2
        exit 1
    fi

    echo "Sharing network with container ${container_id:0:12}"

    local docker_args=(
        -d
        --network "container:${container_id}"
        -e "SERVICES=${SERVICES}"
    )

    if [[ "${TLS_MODE}" == "true" ]]; then
        docker_args+=(
            -v "${TLS_CERT_HOST_PATH}:/etc/localstack/server.pem:ro"
            -e "CUSTOM_SSL_CERT_PATH=/etc/localstack/server.pem"
            -e "SKIP_SSL_CERT_DOWNLOAD=1"
        )
    fi

    LOCALSTACK_CONTAINER=$(docker run "${docker_args[@]}" "${LOCALSTACK_IMG}")
}

wait_for_localstack() {
    local endpoint="http://localhost:4566"
    echo "Waiting for LocalStack at ${endpoint}..."
    for i in $(seq 1 30); do
        if curl -sf "${endpoint}/_localstack/health" >/dev/null 2>&1; then
            echo "LocalStack is ready."
            return 0
        fi
        sleep 1
    done
    echo "LocalStack failed to start."
    exit 1
}

# --- Configure environment ---

setup_environment() {
    export AWS_ACCESS_KEY_ID=test
    export AWS_SECRET_ACCESS_KEY=test
    export AWS_DEFAULT_REGION=us-east-1

    if [[ "${TLS_MODE}" == "true" ]]; then
        export AWS_ENDPOINT_URL="https://localhost:4566"
    else
        export AWS_ENDPOINT_URL="http://localhost:4566"
    fi
}

# --- Run tests ---

start_localstack
wait_for_localstack
setup_environment

echo ""
echo "=== AWS SDK for Zig - Integration Tests ==="
echo "Endpoint: ${AWS_ENDPOINT_URL}"
echo "TLS Mode: ${TLS_MODE}"
echo ""

for scenario_dir in "${SCENARIO_DIRS[@]}"; do
    scenario=$(basename "$scenario_dir")
    echo "--- Running: ${scenario} ---"

    # Run setup script if present
    if [[ -f "${scenario_dir}/setup.sh" ]]; then
        echo "  Running setup..."
        if ! bash "${scenario_dir}/setup.sh"; then
            echo "  SETUP FAILED: ${scenario}"
            ERRORS+=("${scenario} (setup)")
            FAIL=$((FAIL + 1))
            continue
        fi
    fi

    # Source per-scenario environment if present
    if [[ -f "${scenario_dir}/env.sh" ]]; then
        echo "  Sourcing env.sh..."
        source "${scenario_dir}/env.sh"
    fi

    # Build and run test
    echo "  Building and running test..."
    if zig build "integration-test-${scenario}" ${ZIG_BUILD_FLAGS} 2>&1; then
        echo "  PASS: ${scenario}"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: ${scenario}"
        ERRORS+=("${scenario}")
        FAIL=$((FAIL + 1))
    fi

    # Run per-scenario teardown if present
    if [[ -f "${scenario_dir}/teardown.sh" ]]; then
        echo "  Running teardown..."
        bash "${scenario_dir}/teardown.sh" || true
    fi

    echo ""
done

echo "=== Results ==="
echo "Passed: ${PASS}"
echo "Failed: ${FAIL}"

if [[ ${#ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "Failed scenarios:"
    for err in "${ERRORS[@]}"; do
        echo "  - ${err}"
    done
    exit 1
fi

echo "All tests passed."
