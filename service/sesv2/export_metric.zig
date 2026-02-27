const MetricAggregation = @import("metric_aggregation.zig").MetricAggregation;
const Metric = @import("metric.zig").Metric;

/// An object that contains a mapping between a `Metric` and
/// `MetricAggregation`.
pub const ExportMetric = struct {
    aggregation: ?MetricAggregation,

    name: ?Metric,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .name = "Name",
    };
};
