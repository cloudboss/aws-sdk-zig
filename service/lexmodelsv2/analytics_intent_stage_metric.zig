const AnalyticsIntentStageMetricName = @import("analytics_intent_stage_metric_name.zig").AnalyticsIntentStageMetricName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// Contains the metric and the summary statistic you want to calculate, and the
/// order in which to sort the results, for the intent stages across the user
/// sessions with the bot.
pub const AnalyticsIntentStageMetric = struct {
    /// The metric for which you want to get intent stage summary statistics. See
    /// [Key
    /// definitions](https://docs.aws.amazon.com/lexv2/latest/dg/analytics-key-definitions.html) for more details about these metrics.
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
    name: AnalyticsIntentStageMetricName,

    /// Specifies whether to sort the results in ascending or descending order of
    /// the summary statistic (`value` in the response).
    order: ?AnalyticsSortOrder,

    /// The summary statistic to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of intent stages in the
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
