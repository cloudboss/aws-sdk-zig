const GuardrailManagedWordsConfig = @import("guardrail_managed_words_config.zig").GuardrailManagedWordsConfig;
const GuardrailWordConfig = @import("guardrail_word_config.zig").GuardrailWordConfig;

/// Contains details about the word policy to configured for the guardrail.
pub const GuardrailWordPolicyConfig = struct {
    /// A list of managed words to configure for the guardrail.
    managed_word_lists_config: ?[]const GuardrailManagedWordsConfig,

    /// A list of words to configure for the guardrail.
    words_config: ?[]const GuardrailWordConfig,

    pub const json_field_names = .{
        .managed_word_lists_config = "managedWordListsConfig",
        .words_config = "wordsConfig",
    };
};
