const EvaluationAutomationRuleCategory = @import("evaluation_automation_rule_category.zig").EvaluationAutomationRuleCategory;

/// Analysis details providing explanation for Contact Lens automation decision.
pub const EvaluationContactLensAnswerAnalysisDetails = struct {
    /// A list of match rule categories.
    matched_rule_categories: ?[]const EvaluationAutomationRuleCategory,

    pub const json_field_names = .{
        .matched_rule_categories = "MatchedRuleCategories",
    };
};
