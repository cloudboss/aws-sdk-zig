/// The API request rate limits.
pub const ThrottleSettings = struct {
    /// The API target request burst rate limit. This allows more requests through
    /// for a period of time than the target rate limit.
    burst_limit: i32 = 0,

    /// The API target request rate limit.
    rate_limit: f64 = 0,

    pub const json_field_names = .{
        .burst_limit = "burstLimit",
        .rate_limit = "rateLimit",
    };
};
