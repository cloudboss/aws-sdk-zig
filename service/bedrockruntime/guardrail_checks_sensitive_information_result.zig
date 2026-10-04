const GuardrailChecksSensitiveInformationResultEntry = @import("guardrail_checks_sensitive_information_result_entry.zig").GuardrailChecksSensitiveInformationResultEntry;

/// The sensitive information check results.
pub const GuardrailChecksSensitiveInformationResult = struct {
    /// The detected sensitive information entities.
    results: []const GuardrailChecksSensitiveInformationResultEntry,

    /// Specifies whether the results were truncated because the number of detected
    /// entities exceeded the maximum limit.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .results = "results",
        .truncated = "truncated",
    };
};
