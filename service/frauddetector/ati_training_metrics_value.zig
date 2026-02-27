const ATIMetricDataPoint = @import("ati_metric_data_point.zig").ATIMetricDataPoint;
const ATIModelPerformance = @import("ati_model_performance.zig").ATIModelPerformance;

/// The Account Takeover Insights (ATI) model training metric details.
pub const ATITrainingMetricsValue = struct {
    /// The model's performance metrics data points.
    metric_data_points: ?[]const ATIMetricDataPoint,

    /// The model's overall performance scores.
    model_performance: ?ATIModelPerformance,

    pub const json_field_names = .{
        .metric_data_points = "metricDataPoints",
        .model_performance = "modelPerformance",
    };
};
