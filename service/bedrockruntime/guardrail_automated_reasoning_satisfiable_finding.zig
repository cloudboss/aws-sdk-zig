const GuardrailAutomatedReasoningScenario = @import("guardrail_automated_reasoning_scenario.zig").GuardrailAutomatedReasoningScenario;
const GuardrailAutomatedReasoningLogicWarning = @import("guardrail_automated_reasoning_logic_warning.zig").GuardrailAutomatedReasoningLogicWarning;
const GuardrailAutomatedReasoningTranslation = @import("guardrail_automated_reasoning_translation.zig").GuardrailAutomatedReasoningTranslation;

/// Indicates that the claims could be either true or false depending on
/// additional assumptions not provided in the input.
pub const GuardrailAutomatedReasoningSatisfiableFinding = struct {
    /// An example scenario demonstrating how the claims could be logically false.
    claims_false_scenario: ?GuardrailAutomatedReasoningScenario,

    /// An example scenario demonstrating how the claims could be logically true.
    claims_true_scenario: ?GuardrailAutomatedReasoningScenario,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?GuardrailAutomatedReasoningLogicWarning,

    /// The logical translation of the input that this finding evaluates.
    translation: ?GuardrailAutomatedReasoningTranslation,

    pub const json_field_names = .{
        .claims_false_scenario = "claimsFalseScenario",
        .claims_true_scenario = "claimsTrueScenario",
        .logic_warning = "logicWarning",
        .translation = "translation",
    };
};
