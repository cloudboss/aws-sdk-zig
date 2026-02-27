const GuardrailContentFilter = @import("guardrail_content_filter.zig").GuardrailContentFilter;

/// An assessment of a content policy for a guardrail.
pub const GuardrailContentPolicyAssessment = struct {
    /// The content policy filters.
    filters: []const GuardrailContentFilter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
