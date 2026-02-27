const MultiSelectQuestionRuleCategoryAutomation = @import("multi_select_question_rule_category_automation.zig").MultiSelectQuestionRuleCategoryAutomation;

/// An automation option for a multi-select question.
pub const EvaluationFormMultiSelectQuestionAutomationOption = union(enum) {
    /// Rule category configuration for this automation option.
    rule_category: ?MultiSelectQuestionRuleCategoryAutomation,

    pub const json_field_names = .{
        .rule_category = "RuleCategory",
    };
};
