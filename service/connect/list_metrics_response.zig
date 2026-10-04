const MetricSummary = @import("metric_summary.zig").MetricSummary;

pub const ListMetricsResponse = struct {
    /// The list of metric summaries.
    metric_summary_list: []const MetricSummary,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_summary_list = "MetricSummaryList",
        .next_token = "NextToken",
    };
};
