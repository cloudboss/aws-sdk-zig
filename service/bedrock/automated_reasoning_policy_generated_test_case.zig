const AutomatedReasoningCheckResult = @import("automated_reasoning_check_result.zig").AutomatedReasoningCheckResult;

/// Represents a generated test case, consisting of query content, guard
/// content, and expected results.
pub const AutomatedReasoningPolicyGeneratedTestCase = struct {
    /// The expected results of the generated test case. Possible values include:
    ///
    /// * `VALID` - The claims are true. The claims are implied by the premises and
    ///   the Automated Reasoning policy. Given the Automated Reasoning policy and
    ///   premises, it is not possible for these claims to be false. In other words,
    ///   there are no alternative answers that are true that contradict the claims.
    /// * `INVALID` - The claims are false. The claims are not implied by the
    ///   premises and Automated Reasoning policy. Furthermore, there exists
    ///   different claims that are consistent with the premises and Automated
    ///   Reasoning policy.
    /// * `SATISFIABLE` - The claims can be true or false. It depends on what
    ///   assumptions are made for the claim to be implied from the premises and
    ///   Automated Reasoning policy rules. In this situation, different assumptions
    ///   can make input claims false and alternative claims true.
    /// * `IMPOSSIBLE` - Automated Reasoning can’t make a statement about the
    ///   claims. This can happen if the premises are logically incorrect, or if
    ///   there is a conflict within the Automated Reasoning policy itself.
    expected_aggregated_findings_result: AutomatedReasoningCheckResult,

    /// The output content that's validated by the Automated Reasoning policy. This
    /// represents the foundation model response that will be checked for accuracy.
    guard_content: []const u8,

    /// The input query or prompt that generated the content. This provides context
    /// for the validation.
    query_content: []const u8,

    pub const json_field_names = .{
        .expected_aggregated_findings_result = "expectedAggregatedFindingsResult",
        .guard_content = "guardContent",
        .query_content = "queryContent",
    };
};
