const MetricDataPoint = @import("metric_data_point.zig").MetricDataPoint;

/// The training metric details.
pub const TrainingMetrics = struct {
    /// The area under the curve. This summarizes true positive rate (TPR) and false
    /// positive rate (FPR) across all possible model score thresholds. A model with
    /// no predictive power has an AUC of 0.5, whereas a perfect model has a score
    /// of 1.0.
    auc: ?f32,

    /// The data points details.
    metric_data_points: ?[]const MetricDataPoint,

    pub const json_field_names = .{
        .auc = "auc",
        .metric_data_points = "metricDataPoints",
    };
};
