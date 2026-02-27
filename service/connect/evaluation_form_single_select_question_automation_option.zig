const SingleSelectQuestionRuleCategoryAutomation = @import("single_select_question_rule_category_automation.zig").SingleSelectQuestionRuleCategoryAutomation;

/// Information about the automation option of a single select question.
pub const EvaluationFormSingleSelectQuestionAutomationOption = union(enum) {
    /// The automation option based on a rule category for the single select
    /// question.
    rule_category: ?SingleSelectQuestionRuleCategoryAutomation,

    pub const json_field_names = .{
        .rule_category = "RuleCategory",
    };
};
