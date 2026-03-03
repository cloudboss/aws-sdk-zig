const GuardrailCustomWord = @import("guardrail_custom_word.zig").GuardrailCustomWord;
const GuardrailManagedWord = @import("guardrail_managed_word.zig").GuardrailManagedWord;

/// The assessment details for words defined in the Guardrail filter.
pub const GuardrailWordPolicyAssessment = struct {
    /// The custom word details for words defined in the Guardrail filter.
    custom_words: ?[]const GuardrailCustomWord = null,

    /// The managed word lists for words defined in the Guardrail filter.
    managed_word_lists: ?[]const GuardrailManagedWord = null,

    pub const json_field_names = .{
        .custom_words = "customWords",
        .managed_word_lists = "managedWordLists",
    };
};
