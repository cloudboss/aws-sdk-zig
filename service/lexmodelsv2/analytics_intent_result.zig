const AnalyticsBinKey = @import("analytics_bin_key.zig").AnalyticsBinKey;
const AnalyticsIntentGroupByKey = @import("analytics_intent_group_by_key.zig").AnalyticsIntentGroupByKey;
const AnalyticsIntentMetricResult = @import("analytics_intent_metric_result.zig").AnalyticsIntentMetricResult;

/// An object containing the results for the intent metrics you requested and
/// the bin and/or group(s) they refer to, if applicable.
pub const AnalyticsIntentResult = struct {
    /// A list of objects containing the criteria you requested for binning results
    /// and the values of the bins.
    bin_keys: ?[]const AnalyticsBinKey,

    /// A list of objects containing the criteria you requested for grouping results
    /// and the values of the groups.
    group_by_keys: ?[]const AnalyticsIntentGroupByKey,

    /// A list of objects, each of which contains a metric you want to list, the
    /// statistic for the metric you want to return, and the method by which to
    /// organize the results.
    metrics_results: ?[]const AnalyticsIntentMetricResult,

    pub const json_field_names = .{
        .bin_keys = "binKeys",
        .group_by_keys = "groupByKeys",
        .metrics_results = "metricsResults",
    };
};
