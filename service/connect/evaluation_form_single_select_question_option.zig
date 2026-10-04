const AutomaticFailConfiguration = @import("automatic_fail_configuration.zig").AutomaticFailConfiguration;
const QuestionOptionPointsConfiguration = @import("question_option_points_configuration.zig").QuestionOptionPointsConfiguration;

/// Information about the automation configuration in single select questions.
pub const EvaluationFormSingleSelectQuestionOption = struct {
    /// The flag to mark the option as automatic fail. If an automatic fail answer
    /// is provided, the overall evaluation
    /// gets a score of 0.
    automatic_fail: bool = false,

    /// Whether automatic fail is configured on a single select question.
    automatic_fail_configuration: ?AutomaticFailConfiguration = null,

    /// The points configuration for point-based scoring.
    points_configuration: ?QuestionOptionPointsConfiguration = null,

    /// The identifier of the answer option. An identifier must be unique within the
    /// question.
    ref_id: []const u8,

    /// The score assigned to the answer option.
    score: i32 = 0,

    /// The title of the answer option.
    text: []const u8,

    pub const json_field_names = .{
        .automatic_fail = "AutomaticFail",
        .automatic_fail_configuration = "AutomaticFailConfiguration",
        .points_configuration = "PointsConfiguration",
        .ref_id = "RefId",
        .score = "Score",
        .text = "Text",
    };
};
