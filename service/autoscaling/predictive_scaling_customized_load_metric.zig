const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;

/// Describes a custom load metric for a predictive scaling policy.
pub const PredictiveScalingCustomizedLoadMetric = struct {
    /// One or more metric data queries to provide the data points for a load
    /// metric. Use
    /// multiple metric data queries only if you are performing a math expression on
    /// returned
    /// data.
    metric_data_queries: []const MetricDataQuery,
};
