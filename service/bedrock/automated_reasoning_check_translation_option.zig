const AutomatedReasoningCheckTranslation = @import("automated_reasoning_check_translation.zig").AutomatedReasoningCheckTranslation;

/// Represents one possible logical interpretation of ambiguous input content.
pub const AutomatedReasoningCheckTranslationOption = struct {
    /// Different logical interpretations that were detected during translation of
    /// the input.
    translations: ?[]const AutomatedReasoningCheckTranslation = null,

    pub const json_field_names = .{
        .translations = "translations",
    };
};
