const AnalyticsUtteranceMetricName = @import("analytics_utterance_metric_name.zig").AnalyticsUtteranceMetricName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// Contains the metric and the summary statistic you want to calculate, and the
/// order in which to sort the results, for the utterances across the user
/// sessions with the bot.
pub const AnalyticsUtteranceMetric = struct {
    /// The metric for which you want to get utterance summary statistics.
    ///
    /// * `Count` – The number of utterances.
    ///
    /// * `Missed` – The number of utterances that Amazon Lex failed to recognize.
    ///
    /// * `Detected` – The number of utterances that Amazon Lex managed to detect.
    ///
    /// * `UtteranceTimestamp` – The date and time of the utterance.
    name: AnalyticsUtteranceMetricName,

    /// Specifies whether to sort the results in ascending or descending order.
    order: ?AnalyticsSortOrder,

    /// The summary statistic to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of utterances in the
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
