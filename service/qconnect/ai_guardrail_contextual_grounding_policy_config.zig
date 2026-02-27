const GuardrailContextualGroundingFilterConfig = @import("guardrail_contextual_grounding_filter_config.zig").GuardrailContextualGroundingFilterConfig;

/// The policy configuration details for the AI Guardrail's contextual grounding
/// policy.
pub const AIGuardrailContextualGroundingPolicyConfig = struct {
    /// The filter configuration details for the AI Guardrails contextual grounding
    /// policy.
    filters_config: []const GuardrailContextualGroundingFilterConfig,

    pub const json_field_names = .{
        .filters_config = "filtersConfig",
    };
};
