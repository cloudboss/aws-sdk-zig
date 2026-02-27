/// Describes the dimension of a metric.
pub const MetricDimension = struct {
    /// The name of the dimension.
    name: []const u8,

    /// The value of the dimension.
    value: []const u8,
};
