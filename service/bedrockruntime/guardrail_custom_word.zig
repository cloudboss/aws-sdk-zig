const GuardrailWordPolicyAction = @import("guardrail_word_policy_action.zig").GuardrailWordPolicyAction;

/// A custom word configured in a guardrail.
pub const GuardrailCustomWord = struct {
    /// The action for the custom word.
    action: GuardrailWordPolicyAction,

    /// Indicates whether custom word content that breaches the guardrail
    /// configuration is detected.
    detected: ?bool = null,

    /// The match for the custom word.
    match: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .detected = "detected",
        .match = "match",
    };
};
