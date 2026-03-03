const GuardrailManagedWords = @import("guardrail_managed_words.zig").GuardrailManagedWords;
const GuardrailWord = @import("guardrail_word.zig").GuardrailWord;

/// Contains details about the word policy configured for the guardrail.
pub const GuardrailWordPolicy = struct {
    /// A list of managed words configured for the guardrail.
    managed_word_lists: ?[]const GuardrailManagedWords = null,

    /// A list of words configured for the guardrail.
    words: ?[]const GuardrailWord = null,

    pub const json_field_names = .{
        .managed_word_lists = "managedWordLists",
        .words = "words",
    };
};
