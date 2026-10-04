const AutomaticFailConfiguration = @import("automatic_fail_configuration.zig").AutomaticFailConfiguration;
const QuestionOptionPointsConfiguration = @import("question_option_points_configuration.zig").QuestionOptionPointsConfiguration;

/// Information about the option range used for scoring in numeric questions.
pub const EvaluationFormNumericQuestionOption = struct {
    /// The flag to mark the option as automatic fail. If an automatic fail answer
    /// is provided, the overall evaluation
    /// gets a score of 0.
    automatic_fail: bool = false,

    /// A configuration for automatic fail.
    automatic_fail_configuration: ?AutomaticFailConfiguration = null,

    /// The maximum answer value of the range option.
    max_value: i32 = 0,

    /// The minimum answer value of the range option.
    min_value: i32 = 0,

    /// The points configuration for point-based scoring.
    points_configuration: ?QuestionOptionPointsConfiguration = null,

    /// The score assigned to answer values within the range option.
    score: i32 = 0,

    pub const json_field_names = .{
        .automatic_fail = "AutomaticFail",
        .automatic_fail_configuration = "AutomaticFailConfiguration",
        .max_value = "MaxValue",
        .min_value = "MinValue",
        .points_configuration = "PointsConfiguration",
        .score = "Score",
    };
};
