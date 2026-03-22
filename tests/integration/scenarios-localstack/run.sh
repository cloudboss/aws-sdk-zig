#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIOS_DIR="${SCRIPT_DIR}"
CERT_DIR="${SCRIPT_DIR}/../certs"
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
PASS=0
FAIL=0
ERRORS=()

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

    docker_args+=(
        -v "${TLS_CERT_HOST_PATH}:/etc/localstack/server.pem:ro,z"
        -e "CUSTOM_SSL_CERT_PATH=/etc/localstack/server.pem"
        -e "SKIP_SSL_CERT_DOWNLOAD=1"
        -e "GATEWAY_LISTEN=:443"
    )

    LOCALSTACK_CONTAINER=$(docker run "${docker_args[@]}" "${LOCALSTACK_IMG}")
}

wait_for_localstack() {
    local endpoint="https://localhost"
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

# --- Run tests ---

start_localstack
wait_for_localstack

echo ""
echo "=== AWS SDK for Zig - Integration Tests ==="
echo "Endpoint: https://localhost"
echo ""

for scenario_dir in "${SCENARIO_DIRS[@]}"; do
    scenario=$(basename "$scenario_dir")
    echo "--- Running: ${scenario} ---"

    # Run setup script inside a child shell so it gets the base
    # environment defaults without polluting the parent shell.
    if [[ -f "${scenario_dir}/setup.sh" ]]; then
        echo "  Running setup..."
        if ! /bin/sh -c \
            ". '${SCRIPT_DIR}/env.sh' && AWS_ENDPOINT_URL=https://localhost bash '${scenario_dir}/setup.sh'"; then
            echo "  SETUP FAILED: ${scenario}"
            ERRORS+=("${scenario} (setup)")
            FAIL=$((FAIL + 1))
            continue
        fi
    fi

    # Build and run the test inside a child shell that sources the base
    # environment defaults and any per-scenario overrides, preventing
    # env var changes from one scenario bleeding into the next.
    echo "  Building and running test..."
    env_cmd=". '${SCRIPT_DIR}/env.sh'"
    if [[ -f "${scenario_dir}/env.sh" ]]; then
        env_cmd="${env_cmd} && . '${scenario_dir}/env.sh'"
    fi
    if /bin/sh -c "${env_cmd} && zig build 'integration-test-localstack-${scenario}' ${ZIG_BUILD_FLAGS}" 2>&1; then
        echo "  PASS: ${scenario}"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: ${scenario}"
        ERRORS+=("${scenario}")
        FAIL=$((FAIL + 1))
    fi

    # Run per-scenario teardown inside a child shell so it gets the
    # base environment defaults without polluting the parent shell.
    if [[ -f "${scenario_dir}/teardown.sh" ]]; then
        echo "  Running teardown..."
        /bin/sh -c \
            ". '${SCRIPT_DIR}/env.sh' && AWS_ENDPOINT_URL=https://localhost bash '${scenario_dir}/teardown.sh'" \
            || true
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
