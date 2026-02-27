const AnalyticsSessionMetricName = @import("analytics_session_metric_name.zig").AnalyticsSessionMetricName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// Contains the metric and the summary statistic you want to calculate, and the
/// order in which to sort the results, for the user sessions with the bot.
pub const AnalyticsSessionMetric = struct {
    /// The metric for which you want to get session summary statistics.
    ///
    /// * `Count` – The number of sessions.
    ///
    /// * `Success` – The number of sessions that succeeded.
    ///
    /// * `Failure` – The number of sessions that failed.
    ///
    /// * `Dropped` – The number of sessions that the user dropped.
    ///
    /// * `Duration` – The duration of sessions.
    ///
    /// * `TurnsPerSession` – The number of turns in the sessions.
    ///
    /// * `Concurrency` – The number of sessions occurring in the same period of
    ///   time.
    name: AnalyticsSessionMetricName,

    /// Specifies whether to sort the results in ascending or descending order.
    order: ?AnalyticsSortOrder,

    /// The summary statistic to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of sessions in the
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
