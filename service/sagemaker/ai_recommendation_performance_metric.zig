/// An expected performance metric for a recommendation.
pub const AIRecommendationPerformanceMetric = struct {
    /// The name of the performance metric.
    metric: []const u8,

    /// The statistical measure for the metric.
    stat: ?[]const u8 = null,

    /// The unit of the metric value.
    unit: ?[]const u8 = null,

    /// The value of the metric.
    value: []const u8,

    pub const json_field_names = .{
        .metric = "Metric",
        .stat = "Stat",
        .unit = "Unit",
        .value = "Value",
    };
};
