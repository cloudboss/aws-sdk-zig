const AnalyticsBinKey = @import("analytics_bin_key.zig").AnalyticsBinKey;
const AnalyticsIntentStageGroupByKey = @import("analytics_intent_stage_group_by_key.zig").AnalyticsIntentStageGroupByKey;
const AnalyticsIntentStageMetricResult = @import("analytics_intent_stage_metric_result.zig").AnalyticsIntentStageMetricResult;

/// An object containing the results for the intent stage metrics you requested
/// and the bin and/or group they refer to, if applicable.
pub const AnalyticsIntentStageResult = struct {
    /// A list of objects containing the criteria you requested for binning results
    /// and the values of the bins.
    bin_keys: ?[]const AnalyticsBinKey = null,

    /// A list of objects containing the criteria you requested for grouping results
    /// and the values of the bins.
    group_by_keys: ?[]const AnalyticsIntentStageGroupByKey = null,

    /// A list of objects, each of which contains a metric you want to list, the
    /// statistic for the metric you want to return, and the method by which to
    /// organize the results.
    metrics_results: ?[]const AnalyticsIntentStageMetricResult = null,

    pub const json_field_names = .{
        .bin_keys = "binKeys",
        .group_by_keys = "groupByKeys",
        .metrics_results = "metricsResults",
    };
};
