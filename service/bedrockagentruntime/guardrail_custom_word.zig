const GuardrailWordPolicyAction = @import("guardrail_word_policy_action.zig").GuardrailWordPolicyAction;

/// The custom word details for the filter in the Guardrail.
pub const GuardrailCustomWord = struct {
    /// The action details for the custom word filter in the Guardrail.
    action: ?GuardrailWordPolicyAction,

    /// The match details for the custom word filter in the Guardrail.
    match: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
    };
};
