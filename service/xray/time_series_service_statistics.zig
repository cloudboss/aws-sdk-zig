const EdgeStatistics = @import("edge_statistics.zig").EdgeStatistics;
const HistogramEntry = @import("histogram_entry.zig").HistogramEntry;
const ForecastStatistics = @import("forecast_statistics.zig").ForecastStatistics;
const ServiceStatistics = @import("service_statistics.zig").ServiceStatistics;

/// A list of TimeSeriesStatistic structures.
pub const TimeSeriesServiceStatistics = struct {
    edge_summary_statistics: ?EdgeStatistics = null,

    /// The response time histogram for the selected entities.
    response_time_histogram: ?[]const HistogramEntry = null,

    /// The forecasted high and low fault count values.
    service_forecast_statistics: ?ForecastStatistics = null,

    service_summary_statistics: ?ServiceStatistics = null,

    /// Timestamp of the window for which statistics are aggregated.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .edge_summary_statistics = "EdgeSummaryStatistics",
        .response_time_histogram = "ResponseTimeHistogram",
        .service_forecast_statistics = "ServiceForecastStatistics",
        .service_summary_statistics = "ServiceSummaryStatistics",
        .timestamp = "Timestamp",
    };
};
