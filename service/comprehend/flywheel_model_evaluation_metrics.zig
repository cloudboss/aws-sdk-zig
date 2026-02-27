/// The evaluation metrics associated with the evaluated model.
pub const FlywheelModelEvaluationMetrics = struct {
    /// Average accuracy metric for the model.
    average_accuracy: ?f64,

    /// The average F1 score from the evaluation metrics.
    average_f1_score: ?f64,

    /// Average precision metric for the model.
    average_precision: ?f64,

    /// Average recall metric for the model.
    average_recall: ?f64,

    pub const json_field_names = .{
        .average_accuracy = "AverageAccuracy",
        .average_f1_score = "AverageF1Score",
        .average_precision = "AveragePrecision",
        .average_recall = "AverageRecall",
    };
};
