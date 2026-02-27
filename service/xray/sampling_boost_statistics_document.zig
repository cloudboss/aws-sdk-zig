/// Request anomaly stats for a single rule from a service. Results are for the
/// last 10
/// seconds unless the service has been assigned a longer reporting interval
/// after a previous call
/// to
/// [GetSamplingTargets](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingTargets.html).
pub const SamplingBoostStatisticsDocument = struct {
    /// The number of requests with anomaly.
    anomaly_count: i32 = 0,

    /// The name of the sampling rule.
    rule_name: []const u8,

    /// The number of requests with anomaly recorded.
    sampled_anomaly_count: i32 = 0,

    /// Matches the `name` that the service uses to identify itself in segments.
    service_name: []const u8,

    /// The current time.
    timestamp: i64,

    /// The number of requests that associated to the rule.
    total_count: i32 = 0,

    pub const json_field_names = .{
        .anomaly_count = "AnomalyCount",
        .rule_name = "RuleName",
        .sampled_anomaly_count = "SampledAnomalyCount",
        .service_name = "ServiceName",
        .timestamp = "Timestamp",
        .total_count = "TotalCount",
    };
};
