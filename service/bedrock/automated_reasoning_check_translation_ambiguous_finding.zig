const AutomatedReasoningCheckScenario = @import("automated_reasoning_check_scenario.zig").AutomatedReasoningCheckScenario;
const AutomatedReasoningCheckTranslationOption = @import("automated_reasoning_check_translation_option.zig").AutomatedReasoningCheckTranslationOption;

/// Indicates that the input has multiple valid logical interpretations,
/// requiring additional context or clarification.
pub const AutomatedReasoningCheckTranslationAmbiguousFinding = struct {
    /// Scenarios showing how the different translation options differ in meaning.
    difference_scenarios: ?[]const AutomatedReasoningCheckScenario,

    /// Different logical interpretations that were detected during translation of
    /// the input.
    options: ?[]const AutomatedReasoningCheckTranslationOption,

    pub const json_field_names = .{
        .difference_scenarios = "differenceScenarios",
        .options = "options",
    };
};
