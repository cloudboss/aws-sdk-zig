const aws = @import("aws");

const QuestionMetric = @import("question_metric.zig").QuestionMetric;

/// A metric for a particular pillar in a lens.
pub const PillarMetric = struct {
    pillar_id: ?[]const u8 = null,

    /// The questions that have been identified as risks in the pillar.
    questions: ?[]const QuestionMetric = null,

    risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .pillar_id = "PillarId",
        .questions = "Questions",
        .risk_counts = "RiskCounts",
    };
};
