/// Request sampling results for a single rule from a service. Results are for
/// the last 10
/// seconds unless the service has been assigned a longer reporting interval
/// after a previous call
/// to
/// [GetSamplingTargets](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingTargets.html).
pub const SamplingStatisticsDocument = struct {
    /// The number of requests recorded with borrowed reservoir quota.
    borrow_count: i32 = 0,

    /// A unique identifier for the service in hexadecimal.
    client_id: []const u8,

    /// The number of requests that matched the rule.
    request_count: i32 = 0,

    /// The name of the sampling rule.
    rule_name: []const u8,

    /// The number of requests recorded.
    sampled_count: i32 = 0,

    /// The current time.
    timestamp: i64,

    pub const json_field_names = .{
        .borrow_count = "BorrowCount",
        .client_id = "ClientID",
        .request_count = "RequestCount",
        .rule_name = "RuleName",
        .sampled_count = "SampledCount",
        .timestamp = "Timestamp",
    };
};
