const GuardrailManagedWordsType = @import("guardrail_managed_words_type.zig").GuardrailManagedWordsType;

/// The managed word list to configure for the AI Guardrail.
pub const GuardrailManagedWordsConfig = struct {
    /// The managed word type to configure for the AI Guardrail.
    @"type": GuardrailManagedWordsType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
