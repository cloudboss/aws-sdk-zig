const AutomatedReasoningCheckResult = @import("automated_reasoning_check_result.zig").AutomatedReasoningCheckResult;

/// Represents a test scenario used to validate an Automated Reasoning policy,
/// including the test conditions and expected outcomes.
pub const AutomatedReasoningPolicyScenario = struct {
    /// An alternative way to express the same test scenario, used for validation
    /// and comparison purposes.
    alternate_expression: []const u8,

    /// The expected outcome when this scenario is evaluated against the policy
    /// (e.g., PASS, FAIL, VIOLATION).
    expected_result: AutomatedReasoningCheckResult,

    /// The logical expression or condition that defines this test scenario.
    expression: []const u8,

    /// The list of rule identifiers that are expected to be triggered or evaluated
    /// by this test scenario.
    rule_ids: []const []const u8,

    pub const json_field_names = .{
        .alternate_expression = "alternateExpression",
        .expected_result = "expectedResult",
        .expression = "expression",
        .rule_ids = "ruleIds",
    };
};
