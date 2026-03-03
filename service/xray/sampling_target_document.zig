const SamplingBoost = @import("sampling_boost.zig").SamplingBoost;

/// Temporary changes to a sampling rule configuration. To meet the global
/// sampling target for a rule, X-Ray
/// calculates a new reservoir for each service based on the recent sampling
/// results of all services that called
/// [GetSamplingTargets](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingTargets.html).
pub const SamplingTargetDocument = struct {
    /// The percentage of matching requests to instrument, after the reservoir is
    /// exhausted.
    fixed_rate: f64 = 0,

    /// The number of seconds for the service to wait before getting sampling
    /// targets
    /// again.
    interval: ?i32 = null,

    /// The number of requests per second that X-Ray allocated for this service.
    reservoir_quota: ?i32 = null,

    /// When the reservoir quota expires.
    reservoir_quota_ttl: ?i64 = null,

    /// The name of the sampling rule.
    rule_name: ?[]const u8 = null,

    /// The sampling boost that X-Ray allocated for this service.
    sampling_boost: ?SamplingBoost = null,

    pub const json_field_names = .{
        .fixed_rate = "FixedRate",
        .interval = "Interval",
        .reservoir_quota = "ReservoirQuota",
        .reservoir_quota_ttl = "ReservoirQuotaTTL",
        .rule_name = "RuleName",
        .sampling_boost = "SamplingBoost",
    };
};
