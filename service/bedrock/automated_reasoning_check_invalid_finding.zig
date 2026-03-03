const AutomatedReasoningCheckRule = @import("automated_reasoning_check_rule.zig").AutomatedReasoningCheckRule;
const AutomatedReasoningCheckLogicWarning = @import("automated_reasoning_check_logic_warning.zig").AutomatedReasoningCheckLogicWarning;
const AutomatedReasoningCheckTranslation = @import("automated_reasoning_check_translation.zig").AutomatedReasoningCheckTranslation;

/// Indicates that the claims are logically false and contradictory to the
/// established rules or premises.
pub const AutomatedReasoningCheckInvalidFinding = struct {
    /// The automated reasoning policy rules that contradict the claims in the
    /// input.
    contradicting_rules: ?[]const AutomatedReasoningCheckRule = null,

    /// Indication of a logic issue with the translation without needing to consider
    /// the automated reasoning policy rules.
    logic_warning: ?AutomatedReasoningCheckLogicWarning = null,

    /// The logical translation of the input that this finding invalidates.
    translation: ?AutomatedReasoningCheckTranslation = null,

    pub const json_field_names = .{
        .contradicting_rules = "contradictingRules",
        .logic_warning = "logicWarning",
        .translation = "translation",
    };
};
