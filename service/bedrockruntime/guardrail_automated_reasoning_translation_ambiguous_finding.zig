const GuardrailAutomatedReasoningScenario = @import("guardrail_automated_reasoning_scenario.zig").GuardrailAutomatedReasoningScenario;
const GuardrailAutomatedReasoningTranslationOption = @import("guardrail_automated_reasoning_translation_option.zig").GuardrailAutomatedReasoningTranslationOption;

/// Indicates that the input has multiple valid logical interpretations,
/// requiring additional context or clarification.
pub const GuardrailAutomatedReasoningTranslationAmbiguousFinding = struct {
    /// Scenarios showing how the different translation options differ in meaning.
    difference_scenarios: ?[]const GuardrailAutomatedReasoningScenario = null,

    /// Different logical interpretations that were detected during translation of
    /// the input.
    options: ?[]const GuardrailAutomatedReasoningTranslationOption = null,

    pub const json_field_names = .{
        .difference_scenarios = "differenceScenarios",
        .options = "options",
    };
};
