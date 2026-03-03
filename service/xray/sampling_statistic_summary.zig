/// Aggregated request sampling data for a sampling rule across all services for
/// a 10-second window.
pub const SamplingStatisticSummary = struct {
    /// The number of requests recorded with borrowed reservoir quota.
    borrow_count: i32 = 0,

    /// The number of requests that matched the rule.
    request_count: i32 = 0,

    /// The name of the sampling rule.
    rule_name: ?[]const u8 = null,

    /// The number of requests recorded.
    sampled_count: i32 = 0,

    /// The start time of the reporting window.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .borrow_count = "BorrowCount",
        .request_count = "RequestCount",
        .rule_name = "RuleName",
        .sampled_count = "SampledCount",
        .timestamp = "Timestamp",
    };
};
