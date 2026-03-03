/// The configuration for TPS-based traffic shaping. This approach limits
/// requests to the ad decision server (ADS) based on transactions per second
/// and concurrent users.
pub const TrafficShapingTpsConfiguration = struct {
    /// The expected peak number of concurrent viewers for your content. MediaTailor
    /// uses this value along with peak TPS to determine how to distribute prefetch
    /// requests across the available capacity without exceeding your ADS limits.
    peak_concurrent_users: ?i32 = null,

    /// The maximum number of transactions per second (TPS) that your ad decision
    /// server (ADS) can handle. MediaTailor uses this value along with concurrent
    /// users and headroom multiplier to calculate optimal traffic distribution and
    /// prevent ADS overload.
    peak_tps: ?i32 = null,

    pub const json_field_names = .{
        .peak_concurrent_users = "PeakConcurrentUsers",
        .peak_tps = "PeakTps",
    };
};
