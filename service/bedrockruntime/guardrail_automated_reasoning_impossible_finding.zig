const GuardrailAutomatedReasoningRule = @import("guardrail_automated_reasoning_rule.zig").GuardrailAutomatedReasoningRule;
const GuardrailAutomatedReasoningLogicWarning = @import("guardrail_automated_reasoning_logic_warning.zig").GuardrailAutomatedReasoningLogicWarning;
const GuardrailAutomatedReasoningTranslation = @import("guardrail_automated_reasoning_translation.zig").GuardrailAutomatedReasoningTranslation;

/// Indicates that no valid claims can be made due to logical contradictions in
/// the premises or rules.
pub const GuardrailAutomatedReasoningImpossibleFinding = struct {
    /// The automated reasoning policy rules that contradict the claims and/or
    /// premises in the input.
    contradicting_rules: ?[]const GuardrailAutomatedReasoningRule,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?GuardrailAutomatedReasoningLogicWarning,

    /// The logical translation of the input that this finding evaluates.
    translation: ?GuardrailAutomatedReasoningTranslation,

    pub const json_field_names = .{
        .contradicting_rules = "contradictingRules",
        .logic_warning = "logicWarning",
        .translation = "translation",
    };
};
