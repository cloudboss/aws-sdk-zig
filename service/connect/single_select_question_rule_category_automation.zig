const SingleSelectQuestionRuleCategoryAutomationCondition = @import("single_select_question_rule_category_automation_condition.zig").SingleSelectQuestionRuleCategoryAutomationCondition;

/// Information about the automation option based on a rule category for a
/// single select question.
pub const SingleSelectQuestionRuleCategoryAutomation = struct {
    /// The category name, as defined in Rules.
    category: []const u8,

    /// The condition to apply for the automation option. If the condition is
    /// `PRESENT`, then the option is
    /// applied when the contact data includes the category. Similarly, if the
    /// condition is `NOT_PRESENT`, then
    /// the option is applied when the contact data does not include the category.
    condition: SingleSelectQuestionRuleCategoryAutomationCondition,

    /// The identifier of the answer option.
    option_ref_id: []const u8,

    pub const json_field_names = .{
        .category = "Category",
        .condition = "Condition",
        .option_ref_id = "OptionRefId",
    };
};
