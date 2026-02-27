/// The reason for the query throttling, for example, when it exceeds the
/// concurrent query
/// limit.
pub const ThrottleReason = enum {
    concurrent_query_limit_exceeded,

    pub const json_field_names = .{
        .concurrent_query_limit_exceeded = "CONCURRENT_QUERY_LIMIT_EXCEEDED",
    };
};
