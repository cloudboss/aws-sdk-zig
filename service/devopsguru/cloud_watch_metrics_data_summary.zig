const CloudWatchMetricDataStatusCode = @import("cloud_watch_metric_data_status_code.zig").CloudWatchMetricDataStatusCode;
const TimestampMetricValuePair = @import("timestamp_metric_value_pair.zig").TimestampMetricValuePair;

/// Contains information about the analyzed metrics that displayed anomalous
/// behavior.
pub const CloudWatchMetricsDataSummary = struct {
    /// This is an enum of the status showing whether the metric value pair list has
    /// partial
    /// or complete data, or if there was an error.
    status_code: ?CloudWatchMetricDataStatusCode,

    /// This is a list of Amazon CloudWatch metric values at given timestamp.
    timestamp_metric_value_pair_list: ?[]const TimestampMetricValuePair,

    pub const json_field_names = .{
        .status_code = "StatusCode",
        .timestamp_metric_value_pair_list = "TimestampMetricValuePairList",
    };
};
