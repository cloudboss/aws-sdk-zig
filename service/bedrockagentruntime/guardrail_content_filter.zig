const GuardrailContentPolicyAction = @import("guardrail_content_policy_action.zig").GuardrailContentPolicyAction;
const GuardrailContentFilterConfidence = @import("guardrail_content_filter_confidence.zig").GuardrailContentFilterConfidence;
const GuardrailContentFilterType = @import("guardrail_content_filter_type.zig").GuardrailContentFilterType;

/// Details of the content filter used in the Guardrail.
pub const GuardrailContentFilter = struct {
    /// The action placed on the content by the Guardrail filter.
    action: ?GuardrailContentPolicyAction,

    /// The confidence level regarding the content detected in the filter by the
    /// Guardrail.
    confidence: ?GuardrailContentFilterConfidence,

    /// The type of content detected in the filter by the Guardrail.
    type: ?GuardrailContentFilterType,

    pub const json_field_names = .{
        .action = "action",
        .confidence = "confidence",
        .type = "type",
    };
};
