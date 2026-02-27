const aws = @import("aws");

const ExportMetric = @import("export_metric.zig").ExportMetric;
const MetricNamespace = @import("metric_namespace.zig").MetricNamespace;

/// An object that contains details about the data source for the metrics
/// export.
pub const MetricsDataSource = struct {
    /// An object that contains a mapping between a `MetricDimensionName` and
    /// `MetricDimensionValue` to filter metrics by. Must contain a least 1
    /// dimension but no more than 3 unique ones.
    dimensions: []const aws.map.MapEntry([]const []const u8),

    /// Represents the end date for the export interval as a timestamp.
    end_date: i64,

    /// A list of `ExportMetric` objects to export.
    metrics: []const ExportMetric,

    /// The metrics namespace - e.g., `VDM`.
    namespace: MetricNamespace,

    /// Represents the start date for the export interval as a timestamp.
    start_date: i64,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .end_date = "EndDate",
        .metrics = "Metrics",
        .namespace = "Namespace",
        .start_date = "StartDate",
    };
};
