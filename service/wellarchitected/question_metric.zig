const BestPractice = @import("best_practice.zig").BestPractice;
const Risk = @import("risk.zig").Risk;

/// A metric for a particular question in the pillar.
pub const QuestionMetric = struct {
    /// The best practices, or choices, that have been identified as contributing to
    /// risk in a question.
    best_practices: ?[]const BestPractice,

    question_id: ?[]const u8,

    risk: ?Risk,

    pub const json_field_names = .{
        .best_practices = "BestPractices",
        .question_id = "QuestionId",
        .risk = "Risk",
    };
};
