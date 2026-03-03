const CanaryRunState = @import("canary_run_state.zig").CanaryRunState;
const CanaryRunStateReasonCode = @import("canary_run_state_reason_code.zig").CanaryRunStateReasonCode;
const CanaryRunTestResult = @import("canary_run_test_result.zig").CanaryRunTestResult;

/// This structure contains the status information about a canary run.
pub const CanaryRunStatus = struct {
    /// The current state of the run.
    state: ?CanaryRunState = null,

    /// If run of the canary failed, this field contains the reason for the error.
    state_reason: ?[]const u8 = null,

    /// If this value is `CANARY_FAILURE`, either the canary script failed or
    /// Synthetics ran into a fatal error when running the canary. For example, a
    /// canary timeout misconfiguration setting can cause the canary to timeout
    /// before Synthetics can evaluate its status.
    ///
    /// If this value is `EXECUTION_FAILURE`, a non-critical failure occurred such
    /// as failing to save generated debug artifacts (for example, screenshots or
    /// har files).
    ///
    /// If both types of failures occurred, the `CANARY_FAILURE` takes precedence.
    /// To understand the exact error, use the
    /// [StateReason](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_CanaryRunStatus.html) API.
    state_reason_code: ?CanaryRunStateReasonCode = null,

    /// Specifies the status of canary script for this run. When Synthetics tries to
    /// determine the status but fails, the result is marked as `UNKNOWN`.
    /// For the overall status of canary run, see
    /// [State](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_CanaryRunStatus.html).
    test_result: ?CanaryRunTestResult = null,

    pub const json_field_names = .{
        .state = "State",
        .state_reason = "StateReason",
        .state_reason_code = "StateReasonCode",
        .test_result = "TestResult",
    };
};
