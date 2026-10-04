const AutomaticFailConfiguration = @import("automatic_fail_configuration.zig").AutomaticFailConfiguration;
const QuestionOptionPointsConfiguration = @import("question_option_points_configuration.zig").QuestionOptionPointsConfiguration;

/// An option for a multi-select question in an evaluation form.
pub const EvaluationFormMultiSelectQuestionOption = struct {
    /// The flag to mark the option as automatic fail. If an automatic fail answer
    /// is provided, the overall evaluation
    /// gets a score of 0.
    automatic_fail: bool = false,

    automatic_fail_configuration: ?AutomaticFailConfiguration = null,

    /// The points configuration for point-based scoring.
    points_configuration: ?QuestionOptionPointsConfiguration = null,

    /// Reference identifier for this option.
    ref_id: []const u8,

    /// The score assigned to the answer option.
    score: i32 = 0,

    /// Display text for this option.
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
