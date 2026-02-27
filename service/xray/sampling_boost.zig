/// Temporary boost sampling rate. X-Ray calculates sampling boost for each
/// service based on the recent sampling boost stats of all services that called
/// [GetSamplingTargets](https://docs.aws.amazon.com/xray/latest/api/API_GetSamplingTargets.html).
pub const SamplingBoost = struct {
    /// The calculated sampling boost rate for this service
    boost_rate: f64 = 0,

    /// When the sampling boost expires.
    boost_rate_ttl: i64,

    pub const json_field_names = .{
        .boost_rate = "BoostRate",
        .boost_rate_ttl = "BoostRateTTL",
    };
};
