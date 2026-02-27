const GuardrailSensitiveInformationAction = @import("guardrail_sensitive_information_action.zig").GuardrailSensitiveInformationAction;

/// The regular expression to configure for the AI Guardrail.
pub const GuardrailRegexConfig = struct {
    /// The AI Guardrail action to configure when matching regular expression is
    /// detected.
    action: GuardrailSensitiveInformationAction,

    /// The description of the regular expression to configure for the AI Guardrail.
    description: ?[]const u8,

    /// The name of the regular expression to configure for the AI Guardrail.
    name: []const u8,

    /// The regular expression pattern to configure for the AI Guardrail.
    pattern: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .name = "name",
        .pattern = "pattern",
    };
};
