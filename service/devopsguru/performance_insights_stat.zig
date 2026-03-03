/// A statistic in a Performance Insights collection.
pub const PerformanceInsightsStat = struct {
    /// The statistic type.
    @"type": ?[]const u8 = null,

    /// The value of the statistic.
    value: ?f64 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
