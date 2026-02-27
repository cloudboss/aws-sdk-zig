const InputTags = @import("input_tags.zig").InputTags;

/// Account-level enforced guardrail input configuration.
pub const AccountEnforcedGuardrailInferenceInputConfiguration = struct {
    /// Identifier for the guardrail, could be the ID or the ARN.
    guardrail_identifier: []const u8,

    /// Numerical guardrail version.
    guardrail_version: []const u8,

    /// Whether to honor or ignore input tags at runtime.
    input_tags: InputTags,

    pub const json_field_names = .{
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
        .input_tags = "inputTags",
    };
};
