/// The evaluation metrics associated with the evaluated model.
pub const FlywheelModelEvaluationMetrics = struct {
    /// Average accuracy metric for the model.
    average_accuracy: ?f64 = null,

    /// The average F1 score from the evaluation metrics.
    average_f1_score: ?f64 = null,

    /// Average precision metric for the model.
    average_precision: ?f64 = null,

    /// Average recall metric for the model.
    average_recall: ?f64 = null,

    pub const json_field_names = .{
        .average_accuracy = "AverageAccuracy",
        .average_f1_score = "AverageF1Score",
        .average_precision = "AveragePrecision",
        .average_recall = "AverageRecall",
    };
};
