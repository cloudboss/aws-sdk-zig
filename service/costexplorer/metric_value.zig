/// The aggregated value for a metric.
pub const MetricValue = struct {
    /// The actual number that represents the metric.
    amount: ?[]const u8,

    /// The unit that the metric is given in.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .amount = "Amount",
        .unit = "Unit",
    };
};
