const GuardrailManagedWordsConfig = @import("guardrail_managed_words_config.zig").GuardrailManagedWordsConfig;
const GuardrailWordConfig = @import("guardrail_word_config.zig").GuardrailWordConfig;

/// Contains details about the word policy to configured for the AI Guardrail.
pub const AIGuardrailWordPolicyConfig = struct {
    /// A list of managed words to configure for the AI Guardrail.
    managed_word_lists_config: ?[]const GuardrailManagedWordsConfig,

    /// A list of words to configure for the AI Guardrail.
    words_config: ?[]const GuardrailWordConfig,

    pub const json_field_names = .{
        .managed_word_lists_config = "managedWordListsConfig",
        .words_config = "wordsConfig",
    };
};
