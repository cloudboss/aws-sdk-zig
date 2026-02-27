const HistoricalMetricResult = @import("historical_metric_result.zig").HistoricalMetricResult;

pub const GetMetricDataResponse = struct {
    /// Information about the historical metrics.
    ///
    /// If no grouping is specified, a summary of metric data is returned.
    metric_results: ?[]const HistoricalMetricResult,

    /// If there are additional results, this is the token for the next set of
    /// results.
    ///
    /// The token expires after 5 minutes from the time it is created. Subsequent
    /// requests that use
    /// the token must use the same request parameters as the request that generated
    /// the token.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .metric_results = "MetricResults",
        .next_token = "NextToken",
    };
};
