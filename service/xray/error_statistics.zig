/// Information about requests that failed with a 4xx Client Error status code.
pub const ErrorStatistics = struct {
    /// The number of requests that failed with untracked 4xx Client Error status
    /// codes.
    other_count: ?i64,

    /// The number of requests that failed with a 429 throttling status code.
    throttle_count: ?i64,

    /// The total number of requests that failed with a 4xx Client Error status
    /// code.
    total_count: ?i64,

    pub const json_field_names = .{
        .other_count = "OtherCount",
        .throttle_count = "ThrottleCount",
        .total_count = "TotalCount",
    };
};
