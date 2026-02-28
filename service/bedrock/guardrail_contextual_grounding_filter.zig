const GuardrailContextualGroundingAction = @import("guardrail_contextual_grounding_action.zig").GuardrailContextualGroundingAction;
const GuardrailContextualGroundingFilterType = @import("guardrail_contextual_grounding_filter_type.zig").GuardrailContextualGroundingFilterType;

/// The details for the guardrails contextual grounding filter.
pub const GuardrailContextualGroundingFilter = struct {
    /// The action to take when content fails the contextual grounding evaluation.
    /// Supported values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    action: ?GuardrailContextualGroundingAction,

    /// Indicates whether contextual grounding is enabled for evaluation. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    enabled: ?bool,

    /// The threshold details for the guardrails contextual grounding filter.
    threshold: f64,

    /// The filter type details for the guardrails contextual grounding filter.
    type: GuardrailContextualGroundingFilterType,

    pub const json_field_names = .{
        .action = "action",
        .enabled = "enabled",
        .threshold = "threshold",
        .type = "type",
    };
};
