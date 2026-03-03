/// An object that contains the full name, description, and unit of a metric.
pub const ResponseResourceMetric = struct {
    /// The description of the metric.
    description: ?[]const u8 = null,

    /// The full name of the metric.
    metric: ?[]const u8 = null,

    /// The unit of the metric.
    unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .metric = "Metric",
        .unit = "Unit",
    };
};
