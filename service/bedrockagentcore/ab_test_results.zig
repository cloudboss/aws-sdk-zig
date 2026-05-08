const EvaluatorMetric = @import("evaluator_metric.zig").EvaluatorMetric;

/// The statistical results of an A/B test.
pub const ABTestResults = struct {
    /// The timestamp when the analysis was performed.
    analysis_timestamp: ?i64 = null,

    /// The per-evaluator metrics comparing control and treatment variants.
    evaluator_metrics: []const EvaluatorMetric,

    pub const json_field_names = .{
        .analysis_timestamp = "analysisTimestamp",
        .evaluator_metrics = "evaluatorMetrics",
    };
};
