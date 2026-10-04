/// Contains information about the rate limiter status for a connection,
/// including the maximum number of rate limiters allowed, the number currently
/// in use, and the remaining capacity.
pub const RateLimiterStatus = struct {
    /// The number of rate limiters currently in use on the connection.
    in_use: i32 = 0,

    /// The maximum number of rate limiters allowed on the connection.
    max_allowed: i32 = 0,

    /// The number of rate limiters remaining (available) on the connection.
    remaining: i32 = 0,

    /// The total bandwidth allocated across all rate limiters on the connection.
    total_bandwidth: ?[]const u8 = null,

    pub const json_field_names = .{
        .in_use = "inUse",
        .max_allowed = "maxAllowed",
        .remaining = "remaining",
        .total_bandwidth = "totalBandwidth",
    };
};
