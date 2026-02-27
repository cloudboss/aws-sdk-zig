const MultiSelectQuestionRuleCategoryAutomationCondition = @import("multi_select_question_rule_category_automation_condition.zig").MultiSelectQuestionRuleCategoryAutomationCondition;

/// Automation rule for multi-select questions based on rule categories.
pub const MultiSelectQuestionRuleCategoryAutomation = struct {
    /// The category name for this automation rule.
    category: []const u8,

    /// The condition for this automation rule.
    condition: MultiSelectQuestionRuleCategoryAutomationCondition,

    /// Reference IDs of options for this automation rule.
    option_ref_ids: []const []const u8,

    pub const json_field_names = .{
        .category = "Category",
        .condition = "Condition",
        .option_ref_ids = "OptionRefIds",
    };
};
