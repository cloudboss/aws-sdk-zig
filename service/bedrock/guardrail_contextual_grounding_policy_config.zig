const GuardrailContextualGroundingFilterConfig = @import("guardrail_contextual_grounding_filter_config.zig").GuardrailContextualGroundingFilterConfig;

/// The policy configuration details for the guardrails contextual grounding
/// policy.
pub const GuardrailContextualGroundingPolicyConfig = struct {
    /// The filter configuration details for the guardrails contextual grounding
    /// policy.
    filters_config: []const GuardrailContextualGroundingFilterConfig,

    pub const json_field_names = .{
        .filters_config = "filtersConfig",
    };
};
