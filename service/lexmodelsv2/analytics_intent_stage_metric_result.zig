const AnalyticsIntentStageMetricName = @import("analytics_intent_stage_metric_name.zig").AnalyticsIntentStageMetricName;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// An object containing the results for an intent stage metric you requested.
pub const AnalyticsIntentStageMetricResult = struct {
    /// The metric that you requested.
    ///
    /// * `Count` – The number of times the intent stage occurred.
    ///
    /// * `Success` – The number of times the intent stage succeeded.
    ///
    /// * `Failure` – The number of times the intent stage failed.
    ///
    /// * `Dropped` – The number of times the user dropped the intent stage.
    ///
    /// * `Retry` – The number of times the bot tried to elicit a response from the
    ///   user at this stage.
    name: ?AnalyticsIntentStageMetricName,

    /// The summary statistic that you requested to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of intent stages in the
    ///   category you provide in `name`.
    ///
    /// * `Max` – The highest count in the category you provide in `name`.
    statistic: ?AnalyticsMetricStatistic,

    /// The value of the summary statistic for the metric that you requested.
    value: ?f64,

    pub const json_field_names = .{
        .name = "name",
        .statistic = "statistic",
        .value = "value",
    };
};
