const QuestionRuleCategoryAutomationCondition = @import("question_rule_category_automation_condition.zig").QuestionRuleCategoryAutomationCondition;
const EvaluationTranscriptPointOfInterest = @import("evaluation_transcript_point_of_interest.zig").EvaluationTranscriptPointOfInterest;

/// The Contact Lens category used by evaluation automation.
pub const EvaluationAutomationRuleCategory = struct {
    /// A category label.
    category: []const u8,

    /// An automation condition for a Contact Lens category.
    condition: QuestionRuleCategoryAutomationCondition,

    /// A point of interest in a contact transcript that indicates match of
    /// condition.
    points_of_interest: ?[]const EvaluationTranscriptPointOfInterest,

    pub const json_field_names = .{
        .category = "Category",
        .condition = "Condition",
        .points_of_interest = "PointsOfInterest",
    };
};
