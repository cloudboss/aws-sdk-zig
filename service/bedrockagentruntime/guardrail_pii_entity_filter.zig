const GuardrailSensitiveInformationPolicyAction = @import("guardrail_sensitive_information_policy_action.zig").GuardrailSensitiveInformationPolicyAction;
const GuardrailPiiEntityType = @import("guardrail_pii_entity_type.zig").GuardrailPiiEntityType;

/// The Guardrail filter to identify and remove personally identifiable
/// information (PII).
pub const GuardrailPiiEntityFilter = struct {
    /// The action of the Guardrail filter to identify and remove PII.
    action: ?GuardrailSensitiveInformationPolicyAction = null,

    /// The match to settings in the Guardrail filter to identify and remove PII.
    match: ?[]const u8 = null,

    /// The type of PII the Guardrail filter has identified and removed.
    @"type": ?GuardrailPiiEntityType = null,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .@"type" = "type",
    };
};
