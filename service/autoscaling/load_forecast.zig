const PredictiveScalingMetricSpecification = @import("predictive_scaling_metric_specification.zig").PredictiveScalingMetricSpecification;

/// A `GetPredictiveScalingForecast` call returns the load forecast for a
/// predictive scaling policy. This structure includes the data points for that
/// load
/// forecast, along with the timestamps of those data points and the metric
/// specification.
pub const LoadForecast = struct {
    /// The metric specification for the load forecast.
    metric_specification: PredictiveScalingMetricSpecification,

    /// The timestamps for the data points, in UTC format.
    timestamps: []const i64,

    /// The values of the data points.
    values: []const f64,
};
