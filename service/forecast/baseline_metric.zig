/// An individual metric that you can use for comparison as you evaluate your
/// monitoring results.
pub const BaselineMetric = struct {
    /// The name of the metric.
    name: ?[]const u8,

    /// The value for the metric.
    value: ?f64,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
