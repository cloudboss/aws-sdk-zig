/// Aggregated statistics for an evaluator.
pub const EvaluatorStatistics = struct {
    /// The average score across all evaluated sessions for this evaluator.
    average_score: ?f64 = null,

    pub const json_field_names = .{
        .average_score = "averageScore",
    };
};
