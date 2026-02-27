const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;

/// Indicates the CloudWatch math expression that provides the time series the
/// anomaly
/// detector uses as input. The designated math expression must return a single
/// time
/// series.
pub const MetricMathAnomalyDetector = struct {
    /// An array of metric data query structures that enables you to create an
    /// anomaly
    /// detector based on the result of a metric math expression. Each item in
    /// `MetricDataQueries` gets a metric or performs a math expression. One item
    /// in `MetricDataQueries` is the expression that provides the time series that
    /// the anomaly detector uses as input. Designate the expression by setting
    /// `ReturnData` to `true` for this object in the array. For all
    /// other expressions and metrics, set `ReturnData` to `false`. The
    /// designated expression must return a single time series.
    metric_data_queries: ?[]const MetricDataQuery,

    pub const json_field_names = .{
        .metric_data_queries = "MetricDataQueries",
    };
};
