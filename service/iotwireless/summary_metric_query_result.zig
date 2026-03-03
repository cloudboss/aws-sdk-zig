const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const Dimension = @import("dimension.zig").Dimension;
const MetricName = @import("metric_name.zig").MetricName;
const MetricQueryStatus = @import("metric_query_status.zig").MetricQueryStatus;
const MetricQueryValue = @import("metric_query_value.zig").MetricQueryValue;

/// The result of the summary metrics aggregation operation.
pub const SummaryMetricQueryResult = struct {
    /// The aggregation period of the metric.
    aggregation_period: ?AggregationPeriod = null,

    /// The dimensions of the metric.
    dimensions: ?[]const Dimension = null,

    /// The end timestamp for the summary metric query.
    end_timestamp: ?i64 = null,

    /// The error message for the summary metric query result.
    @"error": ?[]const u8 = null,

    /// The name of the summary metric query result.
    metric_name: ?MetricName = null,

    /// The ID of the summary metric results query operation.
    query_id: ?[]const u8 = null,

    /// The status of the summary metric query result.
    query_status: ?MetricQueryStatus = null,

    /// The start timestamp for the summary metric query.
    start_timestamp: ?i64 = null,

    /// The timestamp of each aggregation result.
    timestamps: ?[]const i64 = null,

    /// The units of measurement to be used for interpreting the aggregation result.
    unit: ?[]const u8 = null,

    /// The list of aggregated summary metric query results.
    values: ?[]const MetricQueryValue = null,

    pub const json_field_names = .{
        .aggregation_period = "AggregationPeriod",
        .dimensions = "Dimensions",
        .end_timestamp = "EndTimestamp",
        .@"error" = "Error",
        .metric_name = "MetricName",
        .query_id = "QueryId",
        .query_status = "QueryStatus",
        .start_timestamp = "StartTimestamp",
        .timestamps = "Timestamps",
        .unit = "Unit",
        .values = "Values",
    };
};
