const AnalyticsSessionMetricName = @import("analytics_session_metric_name.zig").AnalyticsSessionMetricName;
const AnalyticsMetricStatistic = @import("analytics_metric_statistic.zig").AnalyticsMetricStatistic;

/// An object containing the results for a session metric you requested.
pub const AnalyticsSessionMetricResult = struct {
    /// The metric that you requested.
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
    /// * `TurnPersession` – The number of turns in the sessions.
    ///
    /// * `Concurrency` – The number of sessions occurring in the same period of
    ///   time.
    name: ?AnalyticsSessionMetricName = null,

    /// The summary statistic that you requested to calculate.
    ///
    /// * `Sum` – The total count for the category you provide in `name`.
    ///
    /// * `Average` – The total count divided by the number of sessions in the
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
