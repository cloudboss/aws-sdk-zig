const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const Dimension = @import("dimension.zig").Dimension;
const MetricName = @import("metric_name.zig").MetricName;
const MetricQueryStatus = @import("metric_query_status.zig").MetricQueryStatus;
const MetricQueryValue = @import("metric_query_value.zig").MetricQueryValue;

/// The result of the summary metrics aggregation operation.
pub const SummaryMetricQueryResult = struct {
    /// The aggregation period of the metric.
    aggregation_period: ?AggregationPeriod,

    /// The dimensions of the metric.
    dimensions: ?[]const Dimension,

    /// The end timestamp for the summary metric query.
    end_timestamp: ?i64,

    /// The error message for the summary metric query result.
    @"error": ?[]const u8,

    /// The name of the summary metric query result.
    metric_name: ?MetricName,

    /// The ID of the summary metric results query operation.
    query_id: ?[]const u8,

    /// The status of the summary metric query result.
    query_status: ?MetricQueryStatus,

    /// The start timestamp for the summary metric query.
    start_timestamp: ?i64,

    /// The timestamp of each aggregation result.
    timestamps: ?[]const i64,

    /// The units of measurement to be used for interpreting the aggregation result.
    unit: ?[]const u8,

    /// The list of aggregated summary metric query results.
    values: ?[]const MetricQueryValue,

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
