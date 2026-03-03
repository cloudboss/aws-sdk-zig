const MetricQuery = @import("metric_query.zig").MetricQuery;
const MetricReference = @import("metric_reference.zig").MetricReference;

/// The representation of a metric.
pub const Metric = struct {
    /// The query to retrieve metric data points.
    metric_query: ?MetricQuery = null,

    /// The name of a metric.
    name: ?[]const u8 = null,

    /// A list of metric references (thresholds).
    references: ?[]const MetricReference = null,

    /// The details of different statistics for a metric. The description might
    /// contain markdown.
    statistics_details: ?[]const u8 = null,
};
