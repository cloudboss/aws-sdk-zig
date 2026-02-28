const GuardrailWordPolicyAction = @import("guardrail_word_policy_action.zig").GuardrailWordPolicyAction;
const GuardrailManagedWordType = @import("guardrail_managed_word_type.zig").GuardrailManagedWordType;

/// The managed word details for the filter in the Guardrail.
pub const GuardrailManagedWord = struct {
    /// The action details for the managed word filter in the Guardrail.
    action: ?GuardrailWordPolicyAction,

    /// The match details for the managed word filter in the Guardrail.
    match: ?[]const u8,

    /// The type details for the managed word filter in the Guardrail.
    type: ?GuardrailManagedWordType,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .type = "type",
    };
};
