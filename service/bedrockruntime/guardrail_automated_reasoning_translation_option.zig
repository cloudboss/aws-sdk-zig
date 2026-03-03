const GuardrailAutomatedReasoningTranslation = @import("guardrail_automated_reasoning_translation.zig").GuardrailAutomatedReasoningTranslation;

/// Represents one possible logical interpretation of ambiguous input content.
pub const GuardrailAutomatedReasoningTranslationOption = struct {
    /// Example translations that provide this possible interpretation of the input.
    translations: ?[]const GuardrailAutomatedReasoningTranslation = null,

    pub const json_field_names = .{
        .translations = "translations",
    };
};
