/// Represents the average latency for the slowest X percent of requests over
/// the last 10
/// seconds.
pub const Latency = struct {
    /// The average latency for the slowest 90 percent of requests over the last 10
    /// seconds.
    p10: ?f64 = null,

    /// The average latency for the slowest 50 percent of requests over the last 10
    /// seconds.
    p50: ?f64 = null,

    /// The average latency for the slowest 25 percent of requests over the last 10
    /// seconds.
    p75: ?f64 = null,

    /// The average latency for the slowest 15 percent of requests over the last 10
    /// seconds.
    p85: ?f64 = null,

    /// The average latency for the slowest 10 percent of requests over the last 10
    /// seconds.
    p90: ?f64 = null,

    /// The average latency for the slowest 5 percent of requests over the last 10
    /// seconds.
    p95: ?f64 = null,

    /// The average latency for the slowest 1 percent of requests over the last 10
    /// seconds.
    p99: ?f64 = null,

    /// The average latency for the slowest 0.1 percent of requests over the last 10
    /// seconds.
    p999: ?f64 = null,
};
