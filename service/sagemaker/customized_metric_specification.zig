const Statistic = @import("statistic.zig").Statistic;

/// A customized metric.
pub const CustomizedMetricSpecification = struct {
    /// The name of the customized metric.
    metric_name: ?[]const u8 = null,

    /// The namespace of the customized metric.
    namespace: ?[]const u8 = null,

    /// The statistic of the customized metric.
    statistic: ?Statistic = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .statistic = "Statistic",
    };
};
