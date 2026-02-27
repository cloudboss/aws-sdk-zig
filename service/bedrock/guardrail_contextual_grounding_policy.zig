const GuardrailContextualGroundingFilter = @import("guardrail_contextual_grounding_filter.zig").GuardrailContextualGroundingFilter;

/// The details for the guardrails contextual grounding policy.
pub const GuardrailContextualGroundingPolicy = struct {
    /// The filter details for the guardrails contextual grounding policy.
    filters: []const GuardrailContextualGroundingFilter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
