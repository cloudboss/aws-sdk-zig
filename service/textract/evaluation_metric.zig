/// The evaluation metrics (F1 score, Precision, and Recall) for an adapter
/// version.
pub const EvaluationMetric = struct {
    /// The F1 score for an adapter version.
    f1_score: f32 = 0,

    /// The Precision score for an adapter version.
    precision: f32 = 0,

    /// The Recall score for an adapter version.
    recall: f32 = 0,

    pub const json_field_names = .{
        .f1_score = "F1Score",
        .precision = "Precision",
        .recall = "Recall",
    };
};
