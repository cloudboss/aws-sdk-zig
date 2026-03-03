/// Round-trip time (RTT) is how long it takes for a request from the user to
/// return a response to the user. Amazon CloudWatch Internet Monitor calculates
/// RTT at different
/// percentiles: p50, p90, and p95.
pub const RoundTripTime = struct {
    /// RTT at the 50th percentile (p50).
    p50: ?f64 = null,

    /// RTT at the 90th percentile (p90).
    p90: ?f64 = null,

    /// RTT at the 95th percentile (p95).
    p95: ?f64 = null,

    pub const json_field_names = .{
        .p50 = "P50",
        .p90 = "P90",
        .p95 = "P95",
    };
};
