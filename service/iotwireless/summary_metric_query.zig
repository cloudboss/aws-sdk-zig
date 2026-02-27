const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const Dimension = @import("dimension.zig").Dimension;
const MetricName = @import("metric_name.zig").MetricName;

/// The summary metric query object.
pub const SummaryMetricQuery = struct {
    /// The aggregation period of the summary metric.
    aggregation_period: ?AggregationPeriod,

    /// The dimensions of the summary metric.
    dimensions: ?[]const Dimension,

    /// The end timestamp for the summary metric query.
    end_timestamp: ?i64,

    /// The name of the metric.
    metric_name: ?MetricName,

    /// The id of the summary metric query.
    query_id: ?[]const u8,

    /// The start timestamp for the summary metric query.
    start_timestamp: ?i64,

    pub const json_field_names = .{
        .aggregation_period = "AggregationPeriod",
        .dimensions = "Dimensions",
        .end_timestamp = "EndTimestamp",
        .metric_name = "MetricName",
        .query_id = "QueryId",
        .start_timestamp = "StartTimestamp",
    };
};
