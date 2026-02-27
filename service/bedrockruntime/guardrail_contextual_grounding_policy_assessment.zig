const GuardrailContextualGroundingFilter = @import("guardrail_contextual_grounding_filter.zig").GuardrailContextualGroundingFilter;

/// The policy assessment details for the guardrails contextual grounding
/// filter.
pub const GuardrailContextualGroundingPolicyAssessment = struct {
    /// The filter details for the guardrails contextual grounding filter.
    filters: ?[]const GuardrailContextualGroundingFilter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
