const AnalyticsUtteranceMetricName = @import("analytics_utterance_metric_name.zig").AnalyticsUtteranceMetricName;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// An object containing the results for the utterance metric you requested.
pub const AnalyticsUtteranceMetricResult = struct {
    /// The metric that you requested.
    ///
    /// * `Count` – The number of utterances.
    ///
    /// * `Missed` – The number of utterances that Amazon Lex failed to recognize.
    ///
    /// * `Detected` – The number of utterances that Amazon Lex managed to detect.
    ///
    /// * `UtteranceTimestamp` – The date and time of the utterance.
    name: ?AnalyticsUtteranceMetricName = null,

    /// The summary statistic that you requested to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of utterances in the
    ///   category you provide in `name`.
    ///
    /// * `Max` – The highest count in the category you provide in `name`.
    statistic: ?AnalyticsMetricStatistic = null,

    /// The value of the summary statistic for the metric that you requested.
    value: ?f64 = null,

    pub const json_field_names = .{
        .name = "name",
        .statistic = "statistic",
        .value = "value",
    };
};
