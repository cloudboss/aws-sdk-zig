const GuardrailCustomWord = @import("guardrail_custom_word.zig").GuardrailCustomWord;
const GuardrailManagedWord = @import("guardrail_managed_word.zig").GuardrailManagedWord;

/// The word policy assessment.
pub const GuardrailWordPolicyAssessment = struct {
    /// Custom words in the assessment.
    custom_words: []const GuardrailCustomWord,

    /// Managed word lists in the assessment.
    managed_word_lists: []const GuardrailManagedWord,

    pub const json_field_names = .{
        .custom_words = "customWords",
        .managed_word_lists = "managedWordLists",
    };
};
