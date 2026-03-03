const AutomatedReasoningCheckRule = @import("automated_reasoning_check_rule.zig").AutomatedReasoningCheckRule;
const AutomatedReasoningCheckLogicWarning = @import("automated_reasoning_check_logic_warning.zig").AutomatedReasoningCheckLogicWarning;
const AutomatedReasoningCheckTranslation = @import("automated_reasoning_check_translation.zig").AutomatedReasoningCheckTranslation;

/// Indicates that no valid claims can be made due to logical contradictions in
/// the premises or rules.
pub const AutomatedReasoningCheckImpossibleFinding = struct {
    /// The automated reasoning policy rules that contradict the claims and/or
    /// premises in the input.
    contradicting_rules: ?[]const AutomatedReasoningCheckRule = null,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?AutomatedReasoningCheckLogicWarning = null,

    /// The logical translation of the input that this finding evaluates.
    translation: ?AutomatedReasoningCheckTranslation = null,

    pub const json_field_names = .{
        .contradicting_rules = "contradictingRules",
        .logic_warning = "logicWarning",
        .translation = "translation",
    };
};
