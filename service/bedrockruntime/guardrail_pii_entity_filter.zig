const GuardrailSensitiveInformationPolicyAction = @import("guardrail_sensitive_information_policy_action.zig").GuardrailSensitiveInformationPolicyAction;
const GuardrailPiiEntityType = @import("guardrail_pii_entity_type.zig").GuardrailPiiEntityType;

/// A Personally Identifiable Information (PII) entity configured in a
/// guardrail.
pub const GuardrailPiiEntityFilter = struct {
    /// The PII entity filter action.
    action: GuardrailSensitiveInformationPolicyAction,

    /// Indicates whether personally identifiable information (PII) that breaches
    /// the guardrail configuration is detected.
    detected: ?bool,

    /// The PII entity filter match.
    match: []const u8,

    /// The PII entity filter type.
    type: GuardrailPiiEntityType,

    pub const json_field_names = .{
        .action = "action",
        .detected = "detected",
        .match = "match",
        .type = "type",
    };
};
