const TFIMetricDataPoint = @import("tfi_metric_data_point.zig").TFIMetricDataPoint;
const TFIModelPerformance = @import("tfi_model_performance.zig").TFIModelPerformance;

/// The Transaction Fraud Insights (TFI) model training metric details.
pub const TFITrainingMetricsValue = struct {
    /// The model's performance metrics data points.
    metric_data_points: ?[]const TFIMetricDataPoint,

    /// The model performance score.
    model_performance: ?TFIModelPerformance,

    pub const json_field_names = .{
        .metric_data_points = "metricDataPoints",
        .model_performance = "modelPerformance",
    };
};
