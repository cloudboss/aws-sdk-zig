const Summary = @import("summary.zig").Summary;

/// The evaluation results for the training of a model.
pub const EvaluationResult = struct {
    /// The F1 score for the evaluation of all labels. The F1 score metric evaluates
    /// the overall precision
    /// and recall performance of the model as a single value. A higher value
    /// indicates better precision
    /// and recall performance. A lower score indicates that precision, recall, or
    /// both are performing poorly.
    f1_score: ?f32,

    /// The S3 bucket that contains the training summary.
    summary: ?Summary,

    pub const json_field_names = .{
        .f1_score = "F1Score",
        .summary = "Summary",
    };
};
