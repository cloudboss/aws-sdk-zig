const Metric = @import("metric.zig").Metric;

/// Represents a single metric value with its associated statistic, such as the
/// sum or average of unused capacity hours.
pub const MetricValue = struct {
    /// The name of the metric.
    metric: ?Metric,

    /// The numerical value of the metric for the specified statistic and time
    /// period.
    value: ?f64,
};
