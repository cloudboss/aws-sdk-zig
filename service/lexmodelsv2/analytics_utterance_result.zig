const AnalyticsUtteranceAttributeResult = @import("analytics_utterance_attribute_result.zig").AnalyticsUtteranceAttributeResult;
const AnalyticsBinKey = @import("analytics_bin_key.zig").AnalyticsBinKey;
const AnalyticsUtteranceGroupByKey = @import("analytics_utterance_group_by_key.zig").AnalyticsUtteranceGroupByKey;
const AnalyticsUtteranceMetricResult = @import("analytics_utterance_metric_result.zig").AnalyticsUtteranceMetricResult;

/// An object containing the results for the utterance metrics you requested and
/// the bin and/or group(s) they refer to, if applicable.
pub const AnalyticsUtteranceResult = struct {
    /// A list of objects containing information about the last used intent at the
    /// time of an utterance.
    attribute_results: ?[]const AnalyticsUtteranceAttributeResult,

    /// A list of objects containing the criteria you requested for binning results
    /// and the values of the bins.
    bin_keys: ?[]const AnalyticsBinKey,

    /// A list of objects containing the criteria you requested for grouping results
    /// and the values of the bins.
    group_by_keys: ?[]const AnalyticsUtteranceGroupByKey,

    /// A list of objects, each of which contains a metric you want to list, the
    /// statistic for the metric you want to return, and the method by which to
    /// organize the results.
    metrics_results: ?[]const AnalyticsUtteranceMetricResult,

    pub const json_field_names = .{
        .attribute_results = "attributeResults",
        .bin_keys = "binKeys",
        .group_by_keys = "groupByKeys",
        .metrics_results = "metricsResults",
    };
};
