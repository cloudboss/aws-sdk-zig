/// A statistic in a Performance Insights collection.
pub const PerformanceInsightsStat = struct {
    /// The statistic type.
    type: ?[]const u8,

    /// The value of the statistic.
    value: ?f64,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
