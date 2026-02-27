const HistoricalMetricData = @import("historical_metric_data.zig").HistoricalMetricData;
const Dimensions = @import("dimensions.zig").Dimensions;

/// Contains information about the historical metrics retrieved.
pub const HistoricalMetricResult = struct {
    /// The set of metrics.
    collections: ?[]const HistoricalMetricData,

    /// The dimension for the metrics.
    dimensions: ?Dimensions,

    pub const json_field_names = .{
        .collections = "Collections",
        .dimensions = "Dimensions",
    };
};
