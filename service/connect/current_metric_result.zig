const CurrentMetricData = @import("current_metric_data.zig").CurrentMetricData;
const Dimensions = @import("dimensions.zig").Dimensions;

/// Contains information about a set of real-time metrics.
pub const CurrentMetricResult = struct {
    /// The set of metrics.
    collections: ?[]const CurrentMetricData = null,

    /// The dimensions for the metrics.
    dimensions: ?Dimensions = null,

    pub const json_field_names = .{
        .collections = "Collections",
        .dimensions = "Dimensions",
    };
};
