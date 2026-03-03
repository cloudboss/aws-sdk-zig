const OFIMetricDataPoint = @import("ofi_metric_data_point.zig").OFIMetricDataPoint;
const OFIModelPerformance = @import("ofi_model_performance.zig").OFIModelPerformance;

/// The Online Fraud Insights (OFI) model training metric details.
pub const OFITrainingMetricsValue = struct {
    /// The model's performance metrics data points.
    metric_data_points: ?[]const OFIMetricDataPoint = null,

    /// The model's overall performance score.
    model_performance: ?OFIModelPerformance = null,

    pub const json_field_names = .{
        .metric_data_points = "metricDataPoints",
        .model_performance = "modelPerformance",
    };
};
