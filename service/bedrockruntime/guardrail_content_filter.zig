const GuardrailContentPolicyAction = @import("guardrail_content_policy_action.zig").GuardrailContentPolicyAction;
const GuardrailContentFilterConfidence = @import("guardrail_content_filter_confidence.zig").GuardrailContentFilterConfidence;
const GuardrailContentFilterStrength = @import("guardrail_content_filter_strength.zig").GuardrailContentFilterStrength;
const GuardrailContentFilterType = @import("guardrail_content_filter_type.zig").GuardrailContentFilterType;

/// The content filter for a guardrail.
pub const GuardrailContentFilter = struct {
    /// The guardrail action.
    action: GuardrailContentPolicyAction,

    /// The guardrail confidence.
    confidence: GuardrailContentFilterConfidence,

    /// Indicates whether content that breaches the guardrail configuration is
    /// detected.
    detected: ?bool = null,

    /// The filter strength setting for the guardrail content filter.
    filter_strength: ?GuardrailContentFilterStrength = null,

    /// The guardrail type.
    @"type": GuardrailContentFilterType,

    pub const json_field_names = .{
        .action = "action",
        .confidence = "confidence",
        .detected = "detected",
        .filter_strength = "filterStrength",
        .@"type" = "type",
    };
};
