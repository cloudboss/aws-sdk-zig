const AnalyticsBinKey = @import("analytics_bin_key.zig").AnalyticsBinKey;
const AnalyticsSessionGroupByKey = @import("analytics_session_group_by_key.zig").AnalyticsSessionGroupByKey;
const AnalyticsSessionMetricResult = @import("analytics_session_metric_result.zig").AnalyticsSessionMetricResult;

/// An object containing the results for the session metrics you requested and
/// the bin and/or group(s) they refer to, if applicable.
pub const AnalyticsSessionResult = struct {
    /// A list of objects containing the criteria you requested for binning results
    /// and the values of the bins.
    bin_keys: ?[]const AnalyticsBinKey,

    /// A list of objects containing the criteria you requested for grouping results
    /// and the values of the bins.
    group_by_keys: ?[]const AnalyticsSessionGroupByKey,

    /// A list of objects, each of which contains a metric you want to list, the
    /// statistic for the metric you want to return, and the method by which to
    /// organize the results.
    metrics_results: ?[]const AnalyticsSessionMetricResult,

    pub const json_field_names = .{
        .bin_keys = "binKeys",
        .group_by_keys = "groupByKeys",
        .metrics_results = "metricsResults",
    };
};
