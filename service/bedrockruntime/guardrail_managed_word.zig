const GuardrailWordPolicyAction = @import("guardrail_word_policy_action.zig").GuardrailWordPolicyAction;
const GuardrailManagedWordType = @import("guardrail_managed_word_type.zig").GuardrailManagedWordType;

/// A managed word configured in a guardrail.
pub const GuardrailManagedWord = struct {
    /// The action for the managed word.
    action: GuardrailWordPolicyAction,

    /// Indicates whether managed word content that breaches the guardrail
    /// configuration is detected.
    detected: ?bool = null,

    /// The match for the managed word.
    match: []const u8,

    /// The type for the managed word.
    @"type": GuardrailManagedWordType,

    pub const json_field_names = .{
        .action = "action",
        .detected = "detected",
        .match = "match",
        .@"type" = "type",
    };
};
