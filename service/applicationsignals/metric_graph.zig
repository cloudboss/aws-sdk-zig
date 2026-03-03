const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;

/// A structure that contains metric data queries and time range information
/// that provides context for audit findings through relevant performance
/// metrics.
pub const MetricGraph = struct {
    /// The end time for the metric data included in this graph. When used in a raw
    /// HTTP Query API, it is formatted as epoch time in seconds.
    end_time: ?i64 = null,

    /// An array of metric data queries that define the metrics to be retrieved and
    /// analyzed as part of the audit finding context.
    metric_data_queries: ?[]const MetricDataQuery = null,

    /// The start time for the metric data included in this graph. When used in a
    /// raw HTTP Query API, it is formatted as epoch time in seconds.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .metric_data_queries = "MetricDataQueries",
        .start_time = "StartTime",
    };
};
