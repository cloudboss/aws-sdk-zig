const MetricQueryResultStatus = @import("metric_query_result_status.zig").MetricQueryResultStatus;

/// The result of a query to retrieve training metrics from SageMaker.
pub const MetricQueryResult = struct {
    /// A message describing the status of the metric query.
    message: ?[]const u8,

    /// The metric values retrieved by the query.
    metric_values: []const f64,

    /// The status of the metric query.
    status: MetricQueryResultStatus,

    /// The values for the x-axis of the metrics.
    x_axis_values: []const i64,

    pub const json_field_names = .{
        .message = "Message",
        .metric_values = "MetricValues",
        .status = "Status",
        .x_axis_values = "XAxisValues",
    };
};
