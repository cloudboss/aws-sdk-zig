const GuardrailAutomatedReasoningScenario = @import("guardrail_automated_reasoning_scenario.zig").GuardrailAutomatedReasoningScenario;
const GuardrailAutomatedReasoningLogicWarning = @import("guardrail_automated_reasoning_logic_warning.zig").GuardrailAutomatedReasoningLogicWarning;
const GuardrailAutomatedReasoningRule = @import("guardrail_automated_reasoning_rule.zig").GuardrailAutomatedReasoningRule;
const GuardrailAutomatedReasoningTranslation = @import("guardrail_automated_reasoning_translation.zig").GuardrailAutomatedReasoningTranslation;

/// Indicates that the claims are definitively true and logically implied by the
/// premises, with no possible alternative interpretations.
pub const GuardrailAutomatedReasoningValidFinding = struct {
    /// An example scenario demonstrating how the claims are logically true.
    claims_true_scenario: ?GuardrailAutomatedReasoningScenario,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?GuardrailAutomatedReasoningLogicWarning,

    /// The automated reasoning policy rules that support why this result is
    /// considered valid.
    supporting_rules: ?[]const GuardrailAutomatedReasoningRule,

    /// The logical translation of the input that this finding validates.
    translation: ?GuardrailAutomatedReasoningTranslation,

    pub const json_field_names = .{
        .claims_true_scenario = "claimsTrueScenario",
        .logic_warning = "logicWarning",
        .supporting_rules = "supportingRules",
        .translation = "translation",
    };
};
