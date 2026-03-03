const DataPoint = @import("data_point.zig").DataPoint;
const ResponseResourceMetricKey = @import("response_resource_metric_key.zig").ResponseResourceMetricKey;

/// A time-ordered series of data points, corresponding to a dimension of a
/// Performance Insights
/// metric.
pub const MetricKeyDataPoints = struct {
    /// An array of timestamp-value pairs, representing measurements over a period
    /// of time.
    data_points: ?[]const DataPoint = null,

    /// The dimensions to which the data points apply.
    key: ?ResponseResourceMetricKey = null,

    pub const json_field_names = .{
        .data_points = "DataPoints",
        .key = "Key",
    };
};
