const GuardrailContextualGroundingFilterType = @import("guardrail_contextual_grounding_filter_type.zig").GuardrailContextualGroundingFilterType;

/// The filter configuration details for the AI Guardrail's contextual grounding
/// filter.
pub const GuardrailContextualGroundingFilterConfig = struct {
    /// The threshold details for the AI Guardrail's contextual grounding filter.
    threshold: f64 = 0,

    /// The filter type for the AI Guardrail's contextual grounding filter.
    type: GuardrailContextualGroundingFilterType,

    pub const json_field_names = .{
        .threshold = "threshold",
        .type = "type",
    };
};
