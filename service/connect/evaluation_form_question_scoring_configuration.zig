const QuestionPointsConfiguration = @import("question_points_configuration.zig").QuestionPointsConfiguration;
const EvaluationFormScoreThreshold = @import("evaluation_form_score_threshold.zig").EvaluationFormScoreThreshold;

/// Scoring configuration for a question in an evaluation form.
pub const EvaluationFormQuestionScoringConfiguration = struct {
    /// The flag to exclude the question from scoring.
    is_excluded_from_scoring: bool = false,

    /// The points configuration for point-based scoring.
    points_configuration: ?QuestionPointsConfiguration = null,

    /// The score thresholds for performance categories.
    score_thresholds: ?[]const EvaluationFormScoreThreshold = null,

    pub const json_field_names = .{
        .is_excluded_from_scoring = "IsExcludedFromScoring",
        .points_configuration = "PointsConfiguration",
        .score_thresholds = "ScoreThresholds",
    };
};
