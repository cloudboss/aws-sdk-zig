const GuardrailSensitiveInformationPolicyAction = @import("guardrail_sensitive_information_policy_action.zig").GuardrailSensitiveInformationPolicyAction;

/// A Regex filter configured in a guardrail.
pub const GuardrailRegexFilter = struct {
    /// The region filter action.
    action: GuardrailSensitiveInformationPolicyAction,

    /// Indicates whether custom regex entities that breach the guardrail
    /// configuration are detected.
    detected: ?bool = null,

    /// The regesx filter match.
    match: ?[]const u8 = null,

    /// The regex filter name.
    name: ?[]const u8 = null,

    /// The regex query.
    regex: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .detected = "detected",
        .match = "match",
        .name = "name",
        .regex = "regex",
    };
};
