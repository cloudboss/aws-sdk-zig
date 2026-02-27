const Dimension = @import("dimension.zig").Dimension;

/// Represents a specific metric.
pub const Metric = struct {
    /// The dimensions for the metric.
    dimensions: ?[]const Dimension,

    /// The name of the metric. This is a required field.
    metric_name: ?[]const u8,

    /// The namespace of the metric.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .metric_name = "MetricName",
        .namespace = "Namespace",
    };
};
