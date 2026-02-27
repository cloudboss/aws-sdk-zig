/// Describes the dimension names and values associated with a metric.
pub const MetricDimension = struct {
    /// The name of the dimension.
    name: []const u8,

    /// The value of the dimension.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
