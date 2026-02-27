const GuardrailContentFilter = @import("guardrail_content_filter.zig").GuardrailContentFilter;

/// The details of the policy assessment in the Guardrails filter.
pub const GuardrailContentPolicyAssessment = struct {
    /// The filter details of the policy assessment used in the Guardrails filter.
    filters: ?[]const GuardrailContentFilter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
