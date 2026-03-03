const Metric = @import("metric.zig").Metric;

/// Details of the performance issue.
pub const PerformanceIssueDetails = struct {
    /// The analysis of the performance issue. The information might contain
    /// markdown.
    analysis: ?[]const u8 = null,

    /// The time when the performance issue stopped.
    end_time: ?i64 = null,

    /// The metrics that are relevant to the performance issue.
    metrics: ?[]const Metric = null,

    /// The time when the performance issue started.
    start_time: ?i64 = null,
};
