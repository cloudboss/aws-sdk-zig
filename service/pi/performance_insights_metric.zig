const aws = @import("aws");

/// This data type helps to determine Performance Insights metric to render for
/// the insight.
pub const PerformanceInsightsMetric = struct {
    /// A dimension map that contains the dimensions for this partition.
    dimensions: ?[]const aws.map.StringMapEntry,

    /// The Performance Insights metric name.
    display_name: ?[]const u8,

    /// The filter for the Performance Insights metric.
    filter: ?[]const aws.map.StringMapEntry,

    /// The Performance Insights metric.
    metric: ?[]const u8,

    /// The value of the metric. For example, `9` for `db.load.avg`.
    value: ?f64,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .display_name = "DisplayName",
        .filter = "Filter",
        .metric = "Metric",
        .value = "Value",
    };
};
