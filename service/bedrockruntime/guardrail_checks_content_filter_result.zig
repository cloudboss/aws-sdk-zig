const GuardrailChecksContentFilterResultEntry = @import("guardrail_checks_content_filter_result_entry.zig").GuardrailChecksContentFilterResultEntry;

/// The content filter check results.
pub const GuardrailChecksContentFilterResult = struct {
    /// The per-category content filter results.
    results: []const GuardrailChecksContentFilterResultEntry,

    pub const json_field_names = .{
        .results = "results",
    };
};
