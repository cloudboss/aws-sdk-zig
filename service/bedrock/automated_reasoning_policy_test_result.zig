const AutomatedReasoningCheckResult = @import("automated_reasoning_check_result.zig").AutomatedReasoningCheckResult;
const AutomatedReasoningPolicyTestCase = @import("automated_reasoning_policy_test_case.zig").AutomatedReasoningPolicyTestCase;
const AutomatedReasoningCheckFinding = @import("automated_reasoning_check_finding.zig").AutomatedReasoningCheckFinding;
const AutomatedReasoningPolicyTestRunResult = @import("automated_reasoning_policy_test_run_result.zig").AutomatedReasoningPolicyTestRunResult;
const AutomatedReasoningPolicyTestRunStatus = @import("automated_reasoning_policy_test_run_status.zig").AutomatedReasoningPolicyTestRunStatus;

/// Contains the results of testing an Automated Reasoning policy against
/// various scenarios and validation checks.
pub const AutomatedReasoningPolicyTestResult = struct {
    /// A summary of all test findings, aggregated to provide an overall assessment
    /// of policy quality and correctness.
    aggregated_test_findings_result: ?AutomatedReasoningCheckResult,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy that was
    /// tested.
    policy_arn: []const u8,

    /// The test case that was executed, including the input content, expected
    /// results, and configuration parameters used during validation.
    test_case: AutomatedReasoningPolicyTestCase,

    /// Detailed findings from the test run, including any issues, violations, or
    /// unexpected behaviors discovered.
    test_findings: ?[]const AutomatedReasoningCheckFinding,

    /// The overall result of the test run, indicating whether the policy passed or
    /// failed validation.
    test_run_result: ?AutomatedReasoningPolicyTestRunResult,

    /// The overall status of the test run (e.g., COMPLETED, FAILED, IN_PROGRESS).
    test_run_status: AutomatedReasoningPolicyTestRunStatus,

    /// The timestamp when the test results were last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .aggregated_test_findings_result = "aggregatedTestFindingsResult",
        .policy_arn = "policyArn",
        .test_case = "testCase",
        .test_findings = "testFindings",
        .test_run_result = "testRunResult",
        .test_run_status = "testRunStatus",
        .updated_at = "updatedAt",
    };
};
