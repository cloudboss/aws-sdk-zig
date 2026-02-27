pub const RecommendationSourceType = enum {
    issue_detection,
    rule_evaluation,
    other,

    pub const json_field_names = .{
        .issue_detection = "ISSUE_DETECTION",
        .rule_evaluation = "RULE_EVALUATION",
        .other = "OTHER",
    };
};
