#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCENARIOS_DIR="${SCRIPT_DIR}"
ZIG_BUILD_FLAGS="${ZIG_BUILD_FLAGS:-}"
SCENARIO="${SCENARIO:-}"

if [[ -n "${SCENARIO}" ]]; then
    SCENARIO_DIRS=("${SCENARIOS_DIR}/${SCENARIO}/")
else
    SCENARIO_DIRS=("${SCENARIOS_DIR}"/*/)
fi

FILTERED_SCENARIOS=()
for scenario_dir in "${SCENARIO_DIRS[@]}"; do
    if [[ -f "${scenario_dir}/test.zig" ]]; then
        FILTERED_SCENARIOS+=("${scenario_dir}")
    fi
done
SCENARIO_DIRS=("${FILTERED_SCENARIOS[@]}")

if [[ ${#SCENARIO_DIRS[@]} -eq 0 ]]; then
    echo "ERROR: No live scenarios found." >&2
    exit 1
fi

if [[ -z "${AWS_ACCESS_KEY_ID:-}" ]] && [[ ! -f "${HOME}/.aws/credentials" ]]; then
    echo "ERROR: No AWS credentials found. Set AWS_ACCESS_KEY_ID or configure ~/.aws/credentials." >&2
    exit 1
fi

if ! account_id=$(aws sts get-caller-identity --query Account --output text 2>/dev/null); then
    echo "ERROR: Failed to validate AWS credentials." >&2
    exit 1
fi

region="${AWS_REGION:-${AWS_DEFAULT_REGION:-}}"
if [[ -z "${region}" ]]; then
    region=$(aws configure get region 2>/dev/null || true)
fi
if [[ -z "${region}" ]]; then
    region="unknown"
fi

PASS=0
FAIL=0
ERRORS=()

cleanup() {
    if [[ -f "${SCRIPT_DIR}/cleanup.sh" ]]; then
        echo "Running live cleanup..."
        bash "${SCRIPT_DIR}/cleanup.sh" || true
    fi
}
trap cleanup EXIT

echo ""
echo "=== AWS SDK for Zig - Live Integration Tests ==="
echo "Account: ${account_id}"
echo "Region: ${region}"
echo ""

for scenario_dir in "${SCENARIO_DIRS[@]}"; do
    scenario=$(basename "$scenario_dir")
    echo "--- Running: ${scenario} ---"

    if [[ -f "${scenario_dir}/setup.sh" ]]; then
        echo "  Running setup..."
        setup_cmd=". '${SCRIPT_DIR}/env.sh'"
        if [[ -f "${scenario_dir}/env.sh" ]]; then
            setup_cmd="${setup_cmd} && . '${scenario_dir}/env.sh'"
        fi
        if ! /bin/sh -c "${setup_cmd} && bash '${scenario_dir}/setup.sh'"; then
            echo "  SETUP FAILED: ${scenario}"
            ERRORS+=("${scenario} (setup)")
            FAIL=$((FAIL + 1))
            echo ""
            continue
        fi
    fi

    echo "  Building and running test..."
    env_cmd=". '${SCRIPT_DIR}/env.sh'"
    if [[ -f "${scenario_dir}/env.sh" ]]; then
        env_cmd="${env_cmd} && . '${scenario_dir}/env.sh'"
    fi
    if /bin/sh -c "${env_cmd} && zig build 'integration-test-live-${scenario}' ${ZIG_BUILD_FLAGS}" 2>&1; then
        echo "  PASS: ${scenario}"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: ${scenario}"
        ERRORS+=("${scenario}")
        FAIL=$((FAIL + 1))
    fi

    if [[ -f "${scenario_dir}/teardown.sh" ]]; then
        echo "  Running teardown..."
        teardown_cmd=". '${SCRIPT_DIR}/env.sh'"
        if [[ -f "${scenario_dir}/env.sh" ]]; then
            teardown_cmd="${teardown_cmd} && . '${scenario_dir}/env.sh'"
        fi
        /bin/sh -c "${teardown_cmd} && bash '${scenario_dir}/teardown.sh'" || true
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
