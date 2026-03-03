const aws = @import("aws");

const MetricDataV2 = @import("metric_data_v2.zig").MetricDataV2;
const MetricInterval = @import("metric_interval.zig").MetricInterval;

/// Contains information about the metric results.
pub const MetricResultV2 = struct {
    /// The set of metrics.
    collections: ?[]const MetricDataV2 = null,

    /// The dimension for the metrics.
    dimensions: ?[]const aws.map.StringMapEntry = null,

    /// The interval period with the start and end time for the metrics.
    metric_interval: ?MetricInterval = null,

    pub const json_field_names = .{
        .collections = "Collections",
        .dimensions = "Dimensions",
        .metric_interval = "MetricInterval",
    };
};
