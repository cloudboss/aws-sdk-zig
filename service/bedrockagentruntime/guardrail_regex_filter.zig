const GuardrailSensitiveInformationPolicyAction = @import("guardrail_sensitive_information_policy_action.zig").GuardrailSensitiveInformationPolicyAction;

/// The details for the regex filter used in the Guardrail.
pub const GuardrailRegexFilter = struct {
    /// The action details for the regex filter used in the Guardrail.
    action: ?GuardrailSensitiveInformationPolicyAction = null,

    /// The match details for the regex filter used in the Guardrail.
    match: ?[]const u8 = null,

    /// The name details for the regex filter used in the Guardrail.
    name: ?[]const u8 = null,

    /// The regex details for the regex filter used in the Guardrail.
    regex: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .name = "name",
        .regex = "regex",
    };
};
