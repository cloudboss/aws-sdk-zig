/// Contains efficiency metrics for a specific point in time, including an
/// efficiency score, potential savings, optimizable spend, and timestamp.
pub const MetricsByTime = struct {
    /// The estimated savings amount for this time period, representing the
    /// potential cost reduction achieved through optimization recommendations.
    savings: ?f64 = null,

    /// The efficiency score for this time period. The score represents a measure of
    /// how effectively the cloud resources are being optimized, with higher scores
    /// indicating better optimization performance.
    score: ?f64 = null,

    /// The total spending amount for this time period.
    spend: ?f64 = null,

    /// The timestamp for this data point. The format depends on the granularity:
    /// YYYY-MM-DD for daily metrics, or YYYY-MM for monthly metrics.
    timestamp: ?[]const u8 = null,

    pub const json_field_names = .{
        .savings = "savings",
        .score = "score",
        .spend = "spend",
        .timestamp = "timestamp",
    };
};
