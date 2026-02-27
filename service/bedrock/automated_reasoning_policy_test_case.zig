const AutomatedReasoningCheckResult = @import("automated_reasoning_check_result.zig").AutomatedReasoningCheckResult;

/// Represents a test for validating an Automated Reasoning policy. tests
/// contain sample inputs and expected outcomes to verify policy behavior.
pub const AutomatedReasoningPolicyTestCase = struct {
    /// The minimum confidence level for logic validation. Content meeting this
    /// threshold is considered high-confidence and can be validated.
    confidence_threshold: ?f64,

    /// The timestamp when the test was created.
    created_at: i64,

    /// The expected result of the Automated Reasoning check for this test.
    expected_aggregated_findings_result: ?AutomatedReasoningCheckResult,

    /// The output content to be validated by the policy, typically representing a
    /// foundation model response.
    guard_content: []const u8,

    /// The input query or prompt that generated the content. This provides context
    /// for the validation.
    query_content: ?[]const u8,

    /// The unique identifier of the test.
    test_case_id: []const u8,

    /// The timestamp when the test was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .confidence_threshold = "confidenceThreshold",
        .created_at = "createdAt",
        .expected_aggregated_findings_result = "expectedAggregatedFindingsResult",
        .guard_content = "guardContent",
        .query_content = "queryContent",
        .test_case_id = "testCaseId",
        .updated_at = "updatedAt",
    };
};
