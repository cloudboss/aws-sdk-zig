pub const UnprocessableExceptionReason = enum {
    query_timeout,
    internal_limit_exceeded,
    memory_limit_exceeded,
    storage_limit_exceeded,
    partition_full,

    pub const json_field_names = .{
        .query_timeout = "QUERY_TIMEOUT",
        .internal_limit_exceeded = "INTERNAL_LIMIT_EXCEEDED",
        .memory_limit_exceeded = "MEMORY_LIMIT_EXCEEDED",
        .storage_limit_exceeded = "STORAGE_LIMIT_EXCEEDED",
        .partition_full = "PARTITION_FULL",
    };
};
