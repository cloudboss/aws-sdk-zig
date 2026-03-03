const AutomatedReasoningCheckScenario = @import("automated_reasoning_check_scenario.zig").AutomatedReasoningCheckScenario;
const AutomatedReasoningCheckLogicWarning = @import("automated_reasoning_check_logic_warning.zig").AutomatedReasoningCheckLogicWarning;
const AutomatedReasoningCheckRule = @import("automated_reasoning_check_rule.zig").AutomatedReasoningCheckRule;
const AutomatedReasoningCheckTranslation = @import("automated_reasoning_check_translation.zig").AutomatedReasoningCheckTranslation;

/// Indicates that the claims are definitively true and logically implied by the
/// premises, with no possible alternative interpretations.
pub const AutomatedReasoningCheckValidFinding = struct {
    /// An example scenario demonstrating how the claims are logically true.
    claims_true_scenario: ?AutomatedReasoningCheckScenario = null,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?AutomatedReasoningCheckLogicWarning = null,

    /// The automated reasoning policy rules that support why this result is
    /// considered valid.
    supporting_rules: ?[]const AutomatedReasoningCheckRule = null,

    /// The logical translation of the input that this finding validates.
    translation: ?AutomatedReasoningCheckTranslation = null,

    pub const json_field_names = .{
        .claims_true_scenario = "claimsTrueScenario",
        .logic_warning = "logicWarning",
        .supporting_rules = "supportingRules",
        .translation = "translation",
    };
};
