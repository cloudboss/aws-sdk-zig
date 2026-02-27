const AnalyticsIntentMetricName = @import("analytics_intent_metric_name.zig").AnalyticsIntentMetricName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// Contains the metric and the summary statistic you want to calculate, and the
/// order in which to sort the results, for the intents in the bot.
pub const AnalyticsIntentMetric = struct {
    /// The metric for which you want to get intent summary statistics.
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
    name: AnalyticsIntentMetricName,

    /// Specifies whether to sort the results in ascending or descending order.
    order: ?AnalyticsSortOrder,

    /// The summary statistic to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of intents in the
    ///   category you provide in `name`.
    ///
    /// * `Max` – The highest count in the category you provide in `name`.
    statistic: AnalyticsMetricStatistic,

    pub const json_field_names = .{
        .name = "name",
        .order = "order",
        .statistic = "statistic",
    };
};
