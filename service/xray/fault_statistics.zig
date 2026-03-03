/// Information about requests that failed with a 5xx Server Error status code.
pub const FaultStatistics = struct {
    /// The number of requests that failed with untracked 5xx Server Error status
    /// codes.
    other_count: ?i64 = null,

    /// The total number of requests that failed with a 5xx Server Error status
    /// code.
    total_count: ?i64 = null,

    pub const json_field_names = .{
        .other_count = "OtherCount",
        .total_count = "TotalCount",
    };
};
