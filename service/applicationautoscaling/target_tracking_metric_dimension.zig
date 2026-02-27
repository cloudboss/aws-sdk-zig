/// Describes the dimension of a metric.
pub const TargetTrackingMetricDimension = struct {
    /// The name of the dimension.
    name: []const u8,

    /// The value of the dimension.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
