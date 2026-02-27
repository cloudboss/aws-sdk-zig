const AutomatedReasoningCheckScenario = @import("automated_reasoning_check_scenario.zig").AutomatedReasoningCheckScenario;
const AutomatedReasoningCheckLogicWarning = @import("automated_reasoning_check_logic_warning.zig").AutomatedReasoningCheckLogicWarning;
const AutomatedReasoningCheckTranslation = @import("automated_reasoning_check_translation.zig").AutomatedReasoningCheckTranslation;

/// Indicates that the claims could be either true or false depending on
/// additional assumptions not provided in the input.
pub const AutomatedReasoningCheckSatisfiableFinding = struct {
    /// An example scenario demonstrating how the claims could be logically false.
    claims_false_scenario: ?AutomatedReasoningCheckScenario,

    /// An example scenario demonstrating how the claims could be logically true.
    claims_true_scenario: ?AutomatedReasoningCheckScenario,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?AutomatedReasoningCheckLogicWarning,

    /// The logical translation of the input that this finding evaluates.
    translation: ?AutomatedReasoningCheckTranslation,

    pub const json_field_names = .{
        .claims_false_scenario = "claimsFalseScenario",
        .claims_true_scenario = "claimsTrueScenario",
        .logic_warning = "logicWarning",
        .translation = "translation",
    };
};
