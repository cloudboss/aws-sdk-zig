const AnalyticsIntentMetricName = @import("analytics_intent_metric_name.zig").AnalyticsIntentMetricName;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// An object containing the results for the intent metric you requested.
pub const AnalyticsIntentMetricResult = struct {
    /// The metric that you requested. See [Key
    /// definitions](https://docs.aws.amazon.com/lexv2/latest/dg/analytics-key-definitions.html) for more details about these metrics.
    ///
    /// * `Count` – The number of times the intent was invoked.
    ///
    /// * `Success` – The number of times the intent succeeded.
    ///
    /// * `Failure` – The number of times the intent failed.
    ///
    /// * `Switched` – The number of times there was a switch to a different intent.
    ///
    /// * `Dropped` – The number of times the user dropped the intent.
    name: ?AnalyticsIntentMetricName,

    /// The statistic that you requested to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of intents in the
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
