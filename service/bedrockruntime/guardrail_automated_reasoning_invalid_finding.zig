const GuardrailAutomatedReasoningRule = @import("guardrail_automated_reasoning_rule.zig").GuardrailAutomatedReasoningRule;
const GuardrailAutomatedReasoningLogicWarning = @import("guardrail_automated_reasoning_logic_warning.zig").GuardrailAutomatedReasoningLogicWarning;
const GuardrailAutomatedReasoningTranslation = @import("guardrail_automated_reasoning_translation.zig").GuardrailAutomatedReasoningTranslation;

/// Indicates that the claims are logically false and contradictory to the
/// established rules or premises.
pub const GuardrailAutomatedReasoningInvalidFinding = struct {
    /// The automated reasoning policy rules that contradict the claims in the
    /// input.
    contradicting_rules: ?[]const GuardrailAutomatedReasoningRule = null,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?GuardrailAutomatedReasoningLogicWarning = null,

    /// The logical translation of the input that this finding invalidates.
    translation: ?GuardrailAutomatedReasoningTranslation = null,

    pub const json_field_names = .{
        .contradicting_rules = "contradictingRules",
        .logic_warning = "logicWarning",
        .translation = "translation",
    };
};
